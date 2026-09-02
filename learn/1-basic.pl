#! user/bin/perl
use strict;
use warnings;

# --- Scalars: Single Values ---
my $name = "LogLens";
my $count = 42;
my $pi = 3.14159;

print "Project: $name\n";
print "Count: $count, Pi: $pi\n";

# --- Arrays: Ordered Lists ---
my @levels = ("INFO", "WARN", "ERROR");
print "First level: $levels[0]\n";                  # index access
print "All levels: @levels\n";                      # interpolate whole array
print "Number of levels: ", scalar(@levels), "\n";  # scalar() gives count

# --- Hashes: Key Value Pairs ---
# --- crucial for log counting later ---
my %status_counts = (
    "200" => 150,
    "404" => 12,
    "301" => 8,
    "500" => 3
);
print "404 count: $status_counts{'404'}\n";

# --- For Loop over a Hash ---
foreach my $code (sort keys %status_counts) {
    print "Status $code -> $status_counts{$code}\n";
}