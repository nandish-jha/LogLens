package LogLens;

use strict;
use warnings;
use Exporter 'import';

# Functions other files may import by name
our @EXPORT_OK = qw(classify_line);

# --- Classify a single log line: returns (level, timestamp) ---
sub classify_line {
    my ($line) = @_;

    my $level = "UNKNOWN";
    if ($line =~ /\b(INFO|WARN|ERROR|DEBUG|FATAL)\b/i) {
        $level = uc($1);
    }

    my $timestamp = "NO_TIMESTAMP";
    if ($line =~ /^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})/) {
        $timestamp = $1;
    }

    return ($level, $timestamp);
}

1;  # A module MUST end with a true value
