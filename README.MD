# BigShebang

Tagline: The archive that carries its own ignition.

```
   ____  _       _____ _          _                  
  | __ )(_) __ _| ____| |__   ___| |__   __ _ _ __   
  |  _ \| |/ _` |  _| | '_ \ / _ \ '_ \ / _` | '_ \  
  | |_) | | (_| | |___| |_) |  __/ | | | (_| | | | | 
  |____/|_|\__, |_____|_.__/ \___|_| |_|\__,_|_| |_| 
          |___/                                      
```

```
                                  ### Brought to you by the 0xacabOS Project ###
```

BigShebang is a secure, self-contained archive creator: a single executable file
that packs a directory, encrypts it, and then unpacks itself anywhere it is run.
Think of it as a .tar.gz that carries its own instructions for how to be born.

The name is deliberate. BigShebang is a play on the big bang and the shebang
"#!" that tells a Unix-like system how to execute a file. The tool is functional
but it is also a gesture: a compact universe that unfolds itself, a recursive 
dream with the extractor embedded inside what it creates.

BigShebang is planned to help populate the filesystems of 0xacabOS, an operating
system in development where these archives can seed the universe of the system.

## At a glance

- One file, self-executing, self-sufficient
- Encrypted and optionally compressed
- Good for sharing, archiving, and project handoffs
- Designed to be portable and resilient

## Why BigShebang (vs. tar.gz)

- BigShebang is self-extracting; no separate extractor needed
- One file includes its own metadata and verification
- Encryption is built in rather than bolted on
- Better suited for handoffs and offline environments

## Features

- AES-256-CBC encryption with PBKDF2 key derivation
- Self-extracting shell archive output
- Multiple compression options: none, gzip, bzip2, xz, zstd
- Metadata support via GNU tar (ACLs, xattrs, SELinux where available)
- List or extract without creating temporary files on disk 
  (beyond a temp workspace)

## Use cases

- Ship a project snapshot that just runs to extract
- Hand off builds without a separate extractor
- Archive and move sensitive directories with a single file
- Seed a new filesystem or environment

## Requirements

- bash
- openssl
- tar
- base64
- awk
- Compression tools (if you use them): gzip, bzip2, xz, zstd

## Install

```bash
sudo cp /home/badkuzushi/BigShebang/bigshebang /usr/local/bin/bigshebang
sudo chmod 755 /usr/local/bin/bigshebang
```

## Usage

Create an archive:

```bash
bigshebang [OPTIONS] <source_directory> [output_file]
```

Common options:

- `-c, --compression TYPE` one of: `none`, `gzip`, `bzip2`, `xz`, `zstd`
- `-p, --password PASS` provide password on the command line
- `-o, --output FILE` output archive file (default: `<source>.secure.sh`)

Extract an archive:

```bash
./archive.secure.sh -p "your_password" -d /path/to/target
```

List archive contents:

```bash
./archive.secure.sh -p "your_password" -l
```

Non-interactive list/extract (fail fast if no password):

```bash
./archive.secure.sh -P -p "your_password" -l
```

## Notes

- Extraction is relative to where you run the self-extractor, or the `-d` 
  directory you pass.
- The self-extracting script embeds the encrypted payload as base64 and verifies
  size and SHA256 before decrypting.

## Philosophy

BigShebang treats packaging as a story: a single artifact that contains both its
universe and the means of unfolding it. It is practical first, but it also nods 
to the symbolism of self-contained creation, and holographic ideation. 

## Version

Current version: `7.23`

## Credits

- Leon Boudreau
- OpenAI Codex assistant
