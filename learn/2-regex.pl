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

# --- Sample log lines to practice on ---
my @sample_lines = (
    "2026-08-20 09:15:01 INFO  User login succeeded",
    "2026-08-20 09:15:04 error Database connection failed",
    "2026-08-20 09:15:07 WARN  Disk usage at 85%",
    "2026-08-20 09:15:09 A line with no level here",
    "2026-08-20 09:15:12 DEBUG Cache hit for key=42",
);

# --- Count each level using a hash ---
my %level_counts;
my @listt;

foreach my $line (@sample_lines) {
    @listt = classify_line($line);
    $level_counts{$listt[0]}++;    # creates empty hash with zero's and then increments
    print $listt[1], " classified as ", $listt[0], "\n";
}

# --- Report ---
print "=== Log Level Summary ===\n";
foreach my $level (sort keys %level_counts) {
    print "$level: $level_counts{$level}\n";
}
