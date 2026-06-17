# Changelog

## 7.23

- Transitioned from Base64 encoding to a binary tail approach for the archive payload.
- Significantly reduced archive size (approx. 25-33% reduction in overhead).
- Improved extraction performance by removing the base64 decoding step.
- Added non-interactive `-P/--no-prompt` for list/extract.
- Improved payload extraction by reading between markers with `awk`. (Refactored to binary tail)
- Fixed tar list invocation for long compression flags (zstd).
- Fixed zstd extraction to pass `--use-compress-program=zstd` correctly.
- Updated product branding to BigShebang.
