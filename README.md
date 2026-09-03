# LogLens 🔍

A lightweight, configurable command-line log analysis tool written in Perl.
It parses log files, detects severity levels, extracts timestamps, and
produces clean summary reports — including frequency-ranked error analysis.

## Features

- Detects standard log levels: **INFO, WARN, ERROR, DEBUG, FATAL**
- Case-insensitive, word-boundary-aware matching
- Extracts ISO-style timestamps (`YYYY-MM-DD HH:MM:SS`)
- Handles malformed lines gracefully (`UNKNOWN` / `NO_TIMESTAMP`)
- **Verbose mode** for per-line inspection
- **Top-errors reporting** — surfaces the most frequent error messages
- Modular design with a reusable `LogLens` module
- Automated test suite (`Test::More`)

## Usage

```bash
perl bin/loglens.pl [options] <logfile>
```

## Options
| Option | Description |
| :--- | :--- |
| --verbose | Print each line as it is classified |
| --top-errors=N | Show the N most frequent ERROR messages |
| --help | Show this help message |

## Example
bash

$ perl bin/loglens.pl --top-errors=3 sample.log
=== LogLens Report: 'sample.log' ===
Total lines analyzed: 11

Log Level Breakdown: DEBUG : 1 ERROR : 3 FATAL : 1 INFO : 3 UNKNOWN : 1 WARN : 2
Top 3 Error Messages: 1 x Failed to connect to database 1 x Retry 1 of 3 failed 1 x Retry 2 of 3 failed

## Project Structure

```text
LogLens/ 
├── bin/loglens.pl   # CLI entry point (argument & flag parsing) 
├── lib/LogLens.pm   # Core parsing module (documented with POD) 
├── t/classify.t     # Automated test suite 
├── sample.log       # Example log data 
└── learn/           # Learning-journey scripts
```

## Running Tests

```bash
prove -l t/
```

## Skills Demonstrated
Perl fundamentals · regular expressions · modular design (bin/lib) · automated testing (Test::More) · CLI development (Getopt::Long) · POD documentation · Git/GitHub workflow

## Roadmap / Future Work

    JSON output mode (--json) for integration with other tools
    Configurable timestamp formats
    Time-range filtering (--since / --until)
    Support for multi-file / directory scanning
