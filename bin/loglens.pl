#!/usr/bin/perl
use strict;
use warnings;

use FindBin;                        # figures out where THIS script lives
use lib "$FindBin::Bin/../lib";     # add ../lib to the module search path
use LogLens qw(classify_line);      # import the function

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
