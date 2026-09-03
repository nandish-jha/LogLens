#!/usr/bin/perl
use strict;
use warnings;

use FindBin;                                        # figures out where THIS script lives
use lib "$FindBin::Bin/../lib";                     # add ../lib to the module search path
use LogLens qw(classify_line extract_message);      # import the function
use Getopt::Long;

# --- Command Line Options ---
my $verbose     = 0;    # --verbose : print each classified line
my $top_errors  = 0;    # --top-errors=N : show N most frequent ERROR messages
my $help        = 0;    # --help : man page

GetOptions(
    "verbose"       => \$verbose,
    "top-errors=i"  => \$top_errors,    # =i means expect an integer
    "help"          => \$help,
) or die "Error parsng options. Try --help\n";

if ($help) {
    print <<"END_HELP";

Usage: $0 [options] <logfile>

Options:
    --verbose       Print each line as it is classified
    --top-errors=N  Show the N most frequent ERROR messages
    --help          Show this help message
END_HELP

    exit 0;
}

# --- Get the filename from the command line ---
my $filename = shift @ARGV
    or die "Usage: $0 <logfile>\n";

open(my $fh, "<", $filename)
    or die "Cannot open the '$filename': $!";   # the $! holds the OS error message

# --- Count each level using a hash ---
my $line_number = 0;
my %level_counts;

# --- Message Text => Count ---
my %error_messages;

while (my $line = <$fh>) {
    chomp $line;    # remove the trailing newline
    $line_number++;

    my ($level, $timestamp) = classify_line($line);
    $level_counts{$level}++;

    # --- Verbose Part ---
    # --verbose brings back the per-line output, ON DEMAND
    if ($verbose) {
        printf "  [%s] %-8s | %s\n", $timestamp, $level, $line;
    }

    # Track ERROR message frequencies for --top-errors
    if ($level eq "ERROR") {
        my $msg = extract_message($line);
        $error_messages{$msg}++;
    }
}

close($fh);

# --- Report ---
print "=== LogLens Report: '$filename' ===\n";
print "Total lines analyzed: $line_number\n\n";
print "Log Level Breakdown: \n";

foreach my $level (sort keys %level_counts) {
    printf "%-8s : %d\n", $level, $level_counts{$level};
}

# --- Optional: top errors ---
if ($top_errors > 0) {
    print "\nTop $top_errors Error Messages: \n";

    # Sort messages by count, descending
    my @sorted = sort { $error_messages{$b} <=> $error_messages{$a} } keys %error_messages;

    my $shown = 0;
    foreach my $msg (@sorted) {
        last if $shown >= $top_errors;
        printf "  %d - %s\n", $error_messages{$msg}, $msg;
        $shown++;
    }
}
