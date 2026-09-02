# LogLens 🔍

A lightweight command-line log analysis tool written in Perl. It parses
log files, detects severity levels, and produces a clean summary report.

## Features

- Detects standard log levels: **INFO, WARN, ERROR, DEBUG, FATAL**
- Case-insensitive, word-boundary-aware matching
- Extracts ISO-style timestamps (`YYYY-MM-DD HH:MM:SS`)
- Handles malformed lines gracefully (`UNKNOWN` / `NO_TIMESTAMP`)
- Modular design with a reusable `LogLens` module
- Automated test suite (`Test::More`)

## Usage

```bash
perl bin/loglens.pl <logfile>
