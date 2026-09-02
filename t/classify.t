#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";
use LogLens qw(classify_line);

use Test::More;

# --- Test 1: a normal INFO line ---
my ($level, $ts) = classify_line("2026-08-24 03:14:01 INFO Server started");
is($level, "INFO",                "detects INFO level");
is($ts,    "2026-08-24 03:14:01", "extracts the timestamp");

# --- Test 2: case-insensitive matching ---
my ($lvl2) = classify_line("2026-08-24 03:16:03 error something broke");
is($lvl2, "ERROR", "lowercase 'error' normalizes to ERROR");

# --- Test 3: a line with no recognizable level ---
my ($lvl3, $ts3) = classify_line("2026-08-24 03:14:09 just some random text");
is($lvl3, "UNKNOWN",             "unmatched level becomes UNKNOWN");
is($ts3,  "2026-08-24 03:14:09", "timestamp still extracted independently");

# --- Test 4: a line with neither timestamp nor level ---
my ($lvl4, $ts4) = classify_line("garbage line");
is($lvl4, "UNKNOWN",      "no level -> UNKNOWN");
is($ts4,  "NO_TIMESTAMP", "no timestamp -> NO_TIMESTAMP");

# --- Test 5: word-boundary check (INFO shouldn't match inside INFORMATION) ---
my ($lvl5) = classify_line("2026-08-24 03:14:01 INFORMATIONAL notice");
is($lvl5, "UNKNOWN", "word boundary prevents matching inside 'INFORMATIONAL'");

done_testing();
