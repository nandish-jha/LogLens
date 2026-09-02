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

# --- Open the File (3 argument form is the modern standard) ---
my $filename = "sample.log";
open(my $fh, "<", $filename)
    or die "Cannot open the '$filename': $!";   # the $! holds the OS error message

# --- Count each level using a hash ---
my $line_number = 0;
my %level_counts;
my @listt;

while (my $line = <$fh>) {
    chomp $line;    # remove the trailing newline
    $line_number++;

    my ($level, $timestamp) = classify_line($line);
    $level_counts{$level}++;
}

close($fh);

# --- Report ---
print "=== Log Level Summary ($line_number lines) ===\n";
foreach my $level (sort keys %level_counts) {
    printf "%-8s : %d\n", $level, $level_counts{$level};
}