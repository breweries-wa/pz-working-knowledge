#!/usr/bin/env perl
# tools/gen_docs.pl — Regenerate DOCUMENTS.md from Working Knowledge mod source files.
#
# Usage (run from the WorkingKnowledge/ directory or any child):
#     perl tools/gen_docs.pl
#
# Source files read (paths resolved relative to this script's parent dir):
#   42/media/scripts/WK_items.txt               → DisplayName per item, in definition order
#   42/media/lua/shared/Translate/EN/Tooltip.json → authoritative short descriptions
#   42/media/lua/client/WK_ContextMenu.lua        → perk string per item
#   42/media/lua/server/WK_Distributions.lua      → container keys per item
#
# Preserved from existing DOCUMENTS.md:
#   • File header (everything before the first ## heading)
#   • ## Category headings and their order
#   • ### Section headings (exact, including decorative markup like *(Sprinting)*)
#   • Italic prose intro paragraph under each ### Section
#
# Fully rebuilt:
#   • Bullet lists — descriptions from Tooltip.json, keys from Distributions.lua
#   • Item order within each section follows WK_items.txt definition order

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use File::Basename qw(dirname);
use File::Spec;
use JSON::PP;

# ── File locations ─────────────────────────────────────────────────────────────
my $HERE  = dirname(File::Spec->rel2abs(__FILE__));
my $ROOT  = dirname($HERE);   # WorkingKnowledge/

my $ITEMS_TXT    = File::Spec->catfile($ROOT, qw(42 media scripts WK_items.txt));
my $TOOLTIP_JSON = File::Spec->catfile($ROOT, qw(42 media lua shared Translate EN Tooltip.json));
my $CONTEXT_LUA  = File::Spec->catfile($ROOT, qw(42 media lua client WK_ContextMenu.lua));
my $DIST_LUA     = File::Spec->catfile($ROOT, qw(42 media lua server WK_Distributions.lua));
my $DOCS_MD      = File::Spec->catfile($ROOT, 'DOCUMENTS.md');

# ── ### Section heading (normalised) → perk string in WK_ContextMenu.lua ───────
my %SECTION_TO_PERK = (
    'Aiming'        => 'Aiming',
    'Reloading'     => 'Reloading',
    'Axe'           => 'Axe',
    'Long Blade'    => 'LongBlade',
    'Maintenance'   => 'Maintenance',
    'Short Blade'   => 'SmallBlade',
    'Short Blunt'   => 'SmallBlunt',
    'Long Blunt'    => 'Blunt',
    'Spear'         => 'Spear',
    'Blacksmithing' => 'Blacksmith',
    'Carpentry'     => 'Woodwork',
    'Carving'       => 'Carving',
    'Cooking'       => 'Cooking',
    'Electrical'    => 'Electricity',
    'Glassmaking'   => 'Glassmaking',
    'Knapping'      => 'FlintKnapping',
    'Masonry'       => 'Masonry',
    'Mechanics'     => 'Mechanics',
    'Pottery'       => 'Pottery',
    'Tailoring'     => 'Tailoring',
    'Welding'       => 'MetalWelding',
    'Agriculture'   => 'Farming',
    'Animal Care'   => 'Husbandry',
    'Butchering'    => 'Butchering',
    'Running'       => 'Sprinting',   # heading is "### Running *(Sprinting)*"
    'Strength'      => 'Strength',
    'First Aid'     => 'Doctor',
    'Fishing'       => 'Fishing',
    'Foraging'      => 'PlantScavenging',
    'Tracking'      => 'Tracking',
    'Trapping'      => 'Trapping',
);

# ── parse_items: bare_type → display_name (ordered array + hash) ───────────────
sub parse_items {
    open my $fh, '<:encoding(UTF-8)', $ITEMS_TXT or die "Cannot open $ITEMS_TXT: $!";
    my $text = do { local $/; <$fh> };
    close $fh;

    my @order;
    my %display;
    while ($text =~ /\bitem\s+(WK_\w+)\s*\{([^}]+)\}/g) {
        my ($bare, $body) = ($1, $2);
        if ($body =~ /DisplayName\s*=\s*(.+?)\s*,/) {
            push @order, $bare unless exists $display{$bare};
            $display{$bare} = $1;
        }
    }
    return (\@order, \%display);
}

# ── parse_tooltips: bare_type → short description ─────────────────────────────
sub parse_tooltips {
    open my $fh, '<:encoding(UTF-8)', $TOOLTIP_JSON or die "Cannot open $TOOLTIP_JSON: $!";
    my $text = do { local $/; <$fh> };
    close $fh;

    my $data = JSON::PP->new->utf8(0)->decode($text);
    my %result;
    for my $key (keys %$data) {
        next unless $key =~ /^Tooltip_(WK_\w+)$/;
        my $bare = $1;
        my $val  = $data->{$key};
        # Description is everything before "\nTrains:" (original items use \n\nTrains:,
        # v2 items use \nTrains: — match both with a single \nTrains: split)
        ($result{$bare} = $val) =~ s/\n+Trains:.*//s;
        $result{$bare} =~ s/^\s+|\s+$//g;
    }
    return \%result;
}

# ── parse_perks: bare_type → perk string ──────────────────────────────────────
sub parse_perks {
    open my $fh, '<:encoding(UTF-8)', $CONTEXT_LUA or die "Cannot open $CONTEXT_LUA: $!";
    my $text = do { local $/; <$fh> };
    close $fh;

    my %result;
    while ($text =~ /\b(WK_\w+)\s*=\s*"(\w+)"/g) {
        $result{$1} = $2;
    }
    return \%result;
}

# ── parse_distributions: bare_type → [ContainerKey, ...] ─────────────────────
sub parse_distributions {
    open my $fh, '<:encoding(UTF-8)', $DIST_LUA or die "Cannot open $DIST_LUA: $!";
    my $text = do { local $/; <$fh> };
    close $fh;

    my %result;

    # addMany blocks: if dist.ContainerKey and dist.ContainerKey.items then ... end
    while ($text =~ /if\s+dist\.(\w+)\s+and\s+dist\.\w+\.items\s+then(.*?)end/gs) {
        my ($container, $body) = ($1, $2);
        while ($body =~ /"(WK_\w+)"/g) {
            my $bare = $1;
            unless (grep { $_ eq $container } @{ $result{$bare} // [] }) {
                push @{ $result{$bare} }, $container;
            }
        }
    }

    # Standalone addToItems calls
    while ($text =~ /addToItems\s*\(\s*dist\.(\w+)\.items\s*,\s*"(WK_\w+)"/g) {
        my ($container, $bare) = ($1, $2);
        unless (grep { $_ eq $container } @{ $result{$bare} // [] }) {
            push @{ $result{$bare} }, $container;
        }
    }

    return \%result;
}

# ── parse_docs: extract structure from existing DOCUMENTS.md ──────────────────
sub parse_docs {
    open my $fh, '<:encoding(UTF-8)', $DOCS_MD or die "Cannot open $DOCS_MD: $!";
    my @lines = map { chomp; $_ } <$fh>;
    close $fh;

    my @header_lines;
    my @sections;
    my $current_h2  = undef;
    my $current_sec = undef;
    my $seen_h2     = 0;
    my $in_intro    = 0;

    for my $line (@lines) {
        next if $line eq '---';   # structural separator, reproduced in output

        if ($line =~ /^## /) {
            $seen_h2 = 1;
            $current_h2  = $line;
            $current_sec = undef;
            $in_intro    = 0;
            next;
        }

        if ($line =~ /^### (.+)$/) {
            my $h3_plain = $1;
            # Normalise: remove *(...)* and leftover asterisks
            (my $h3_key = $h3_plain) =~ s/\s*\*\([^)]*\)\*\s*//g;
            $h3_key =~ s/\*//g;
            $h3_key =~ s/^\s+|\s+$//g;

            $current_sec = {
                h2          => $current_h2,
                h3_raw      => $line,
                h3_key      => $h3_key,
                intro_lines => [],
            };
            push @sections, $current_sec;
            $in_intro = 1;
            next;
        }

        if (!$seen_h2) {
            push @header_lines, $line;
            next;
        }

        if (defined $current_sec) {
            if ($line =~ /^- /) {
                $in_intro = 0;   # first bullet — stop collecting intro
                next;            # skip existing bullets
            }
            push @{ $current_sec->{intro_lines} }, $line if $in_intro;
        }
    }

    # Strip trailing blank lines from header
    pop @header_lines while @header_lines && $header_lines[-1] !~ /\S/;

    return (\@header_lines, \@sections);
}

# ── trim_blank_edges: strip leading/trailing blank entries from an arrayref ────
sub trim_blank_edges {
    my @lines = @{ $_[0] };
    shift @lines while @lines && $lines[0]  !~ /\S/;
    pop   @lines while @lines && $lines[-1] !~ /\S/;
    return @lines;
}

# ── make_bullet: format one document entry ────────────────────────────────────
sub make_bullet {
    my ($display, $desc, $keys_ref) = @_;
    if (@$keys_ref) {
        my $keys_str = join ', ', map { "`$_`" } @$keys_ref;
        return "- **$display** — $desc Keys: $keys_str";
    }
    return "- **$display** — $desc";
}

# ── main ──────────────────────────────────────────────────────────────────────
my ($item_order, $display) = parse_items();
my $tooltips = parse_tooltips();
my $perks    = parse_perks();
my $dists    = parse_distributions();
my ($header_lines, $sections) = parse_docs();

# Build perk → [bare_type, ...] preserving WK_items.txt order
my %perk_to_items;
for my $bare (@$item_order) {
    my $perk = $perks->{$bare} or next;
    push @{ $perk_to_items{$perk} }, $bare;
}

# ── Generate output ───────────────────────────────────────────────────────────
my @out;

push @out, @$header_lines;
push @out, '';
push @out, '---';
push @out, '';

my $prev_h2 = undef;

for my $sec (@$sections) {
    my $h2     = $sec->{h2};
    my $h3_raw = $sec->{h3_raw};
    my $h3_key = $sec->{h3_key};

    # ── Category separator ──────────────────────────────────────────────────
    if (!defined($prev_h2) || $h2 ne $prev_h2) {
        if (defined $prev_h2) {
            # Trim trailing blanks, then emit separator
            pop @out while @out && $out[-1] !~ /\S/;
            push @out, '';
            push @out, '---';
            push @out, '';
        }
        push @out, $h2;
        $prev_h2 = $h2;
    }

    # ── Section heading ─────────────────────────────────────────────────────
    push @out, '';
    push @out, $h3_raw;
    push @out, '';

    # ── Intro prose (preserved verbatim) ────────────────────────────────────
    my @intro = trim_blank_edges($sec->{intro_lines});
    push @out, @intro;
    push @out, '';

    # ── Bullets ─────────────────────────────────────────────────────────────
    my $perk = $SECTION_TO_PERK{$h3_key};
    unless (defined $perk) {
        warn "  WARNING: no SECTION_TO_PERK entry for '$h3_key' (heading: $h3_raw)\n";
        push @out, qq[<!-- gen_docs.pl: no perk mapping for section "$h3_key" -->];
        next;
    }

    my @bare_list = @{ $perk_to_items{$perk} // [] };
    warn "  WARNING: no items for perk '$perk' (section: $h3_key)\n" unless @bare_list;

    for my $bare (@bare_list) {
        my $disp = $display->{$bare} // $bare;
        my $desc = $tooltips->{$bare} // '(missing tooltip)';
        my $keys = $dists->{$bare}   // [];
        push @out, make_bullet($disp, $desc, $keys);
    }
}

push @out, '';

# ── Write output ──────────────────────────────────────────────────────────────
open my $out_fh, '>:encoding(UTF-8)', $DOCS_MD or die "Cannot write $DOCS_MD: $!";
print $out_fh join("\n", @out);
close $out_fh;

# ── Summary ───────────────────────────────────────────────────────────────────
my $total = 0;
$total += scalar @{ $perk_to_items{$_} // [] } for values %SECTION_TO_PERK;

printf "Wrote %s\n", $DOCS_MD;
printf "Total items: %d\n\n", $total;
printf "%-22s %-22s %s\n", 'Section', 'Perk', 'Items';
print  '-' x 55, "\n";
for my $sec (@$sections) {
    my $perk  = $SECTION_TO_PERK{ $sec->{h3_key} } // '???';
    my $count = scalar @{ $perk_to_items{$perk} // [] };
    printf "  %-20s %-22s %d\n", $sec->{h3_key}, $perk, $count;
}
