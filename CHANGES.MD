# Changelog

> Versioning reset to `0.5`; earlier `7.23` labels are retired.

## 0.5 (Provenance Edition)

- Added `--provenance` flag: emits a machine-readable SHA-256 provenance chain
  (Archive → Vessel → Final Script) for non-interactive capture.
- Grimoire manifest now includes hidden provenance directories (e.g.
  `.conception/`); only `.git/` is excluded by default.
- Generated vessels now parse arguments before displaying the banner, so
  `-B/--no-banner` reliably suppresses header output (including the leading
  blank line).
- Removed `eval` from the vessel archive-listing path.
- Cleaned ShellCheck warnings (SC2086 tar flags via array, SC2155, SC2295,
  SC2034 unused vars, SC2129 grouped redirects).
- `stress_test.sh` is now executable in-tree.
- Adopted commit-aware versioning; reset release label to `0.5`.

## Prior (pre-0.5)

- Transitioned from Base64 encoding to a binary tail approach for the archive payload.
- Significantly reduced archive size (approx. 25-33% reduction in overhead).
- Improved extraction performance by removing the base64 decoding step.
- Added non-interactive `-P/--no-prompt` for list/extract.
- Improved payload extraction by reading between markers with `awk`. (Refactored to binary tail)
- Fixed tar list invocation for long compression flags (zstd).
- Fixed zstd extraction to pass `--use-compress-program=zstd` correctly.
- Updated product branding to BigShebang.
