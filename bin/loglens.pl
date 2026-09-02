#!/usr/bin/perl
use strict;
use warnings;

# --- A Subroutine: Reuseable Block of Logic ---
sub classify_line {
    my ($line) = @_;    # unpack the argument

    # match a log level anywhere in the line
    # \b = word boundary; () = capture group; i = case-insensitive
    my $level = "UNKNOWN";
    if ($line =~ /\b(INFO|WARN|ERROR|DEBUG|FATAL)\b/i) {
        $level = uc($1);  # $1 = first captured group; uc() = uppercase
    }

    my $timestamp = "NO_TIMESTAMP";
    if ($line =~ /^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})/) {
        $timestamp = $1;
    }

    return ($level, $timestamp);
}

# --- Get the filename from the command line ---
my $filename = shift @ARGV
    or die "Usage: $0 <logfile>\n";

open(my $fh, "<", $filename)
    or die "Cannot open the '$filename': $!";   # the $! holds the OS error message

# --- Count each level using a hash ---
my $line_number = 0;
my %level_counts;

while (my $line = <$fh>) {
    chomp $line;    # remove the trailing newline
    $line_number++;

    my ($level, $timestamp) = classify_line($line);
    $level_counts{$level}++;
}

close($fh);

# --- Report ---
print "=== LogLens Report: '$filename' ===\n";
print "Total lines analyzed: $line_number\n\n";
print "Log Level Breakdown: \n";

foreach my $level (sort keys %level_counts) {
    printf "%-8s : %d\n", $level, $level_counts{$level};
}
