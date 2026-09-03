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

| Option          | Description |
| --verbose       | Print each line as it is classified |
| --top-errors=N  | Show the N most frequent ERROR messages |
| --help          | Show this help message |
