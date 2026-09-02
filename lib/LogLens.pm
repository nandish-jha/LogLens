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

__END__

=head1 NAME

LogLens - Parse and classify log file lines by severity level

=head1 SYNOPSIS

    use LogLens qw(classify_line);

    my ($level, $timestamp) = classify_line($line);

=head1 DESCRIPTION

LogLens provides utilities for analyzing plain-text log files. It detects
standard severity levels (INFO, WARN, ERROR, DEBUG, FATAL) and extracts
ISO-style timestamps from log lines.

=head1 FUNCTIONS

=head2 classify_line($line)

Takes a single log line as a string. Returns a two-element list:
C<($level, $timestamp)>.

=over 4

=item * B<$level> - one of INFO, WARN, ERROR, DEBUG, FATAL (uppercased),
or "UNKNOWN" if no level is found. Matching is case-insensitive and uses
word boundaries.

=item * B<$timestamp> - the leading C<YYYY-MM-DD HH:MM:SS> timestamp,
or "NO_TIMESTAMP" if none is present.

=back

=head1 AUTHOR

Nandish Jha

=cut
