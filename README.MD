# BigShebang 🌌

**The archive that carries its own ignition.**

BigShebang is a secure, self-contained archive creator: a single executable file that packs a directory, encrypts it, and then unpacks itself anywhere it is run. It is implemented as a deterministic **State Machine Automaton** within a single Bash script.

Built for the **0xacabOS** ecosystem, BigShebang treats packaging as a lifecycle: a compact universe that unfolds itself through a cryptographically verified chain of custody.

---

## 🛠 Features

- **Automaton Architecture:** Orchestrated as a formal state machine for deterministic resilience and absolute reliability.
- **Binary Tail Extraction:** High-performance payload delivery. No Base64 overhead; the archive is appended directly to the script tail and sliced out with byte-level precision.
- **Cryptographic Provenance:** Every transformation (Archive -> Encrypt -> Assemble) generates a SHA-256 signature, creating a verifiable chain of custody.
- **Grimoire Oracle:** A dedicated knowledge layer (`--grimoire`) that speaks the project's intent and holographic manifest to humans and AIs without decryption.
- **Self-Validating:** Internal self-diagnostic protocol (`--self-test`) ensures the environment is capable of perfect integrity before processing data.
- **Recursive Extraction:** The archive can carry a copy of its own creator (`-R`), ensuring the "recursive dream" of self-contained distribution.
- **High Fidelity:** Full preservation of GNU tar metadata, including ACLs, xattrs, and SELinux contexts.
- **3l33t Aesthetics:** Native support for `file_id.diz` ANSI banners and a clean, high-signal CLI interface.

## 🔒 Security

- **Encryption:** AES-256-CBC via OpenSSL.
- **Key Derivation:** PBKDF2 with 100,000 iterations and SHA-512.
- **Integrity:** Mandatory SHA-256 verification of the payload before decryption.

## 🚀 Usage

### Create an Archive
```bash
./bigshebang [OPTIONS] <source_directory> [output_file]
```
**Options:**
- `-c, --compress TYPE` : none, gzip, bzip2, xz, zstd (default: gzip)
- `-p, --password PASS` : Provide password (prompted if omitted)
- `-R, --recursive`     : Include a copy of `bigshebang` inside the archive
- `-T, --self-test`    : Run internal self-diagnostic before archiving
- `-B, --no-banner`      : Suppress branding output

### Extract
```bash
./my_project.secure.sh -p "your_password" -d /path/to/target
```

### Commune with the Grimoire
```bash
./my_project.secure.sh --grimoire
```

## 🏗 Philosophy

BigShebang treats the file format not just as a container, but as a **Protocol**. By moving from procedural logic to a state-machine automaton, we ensure that the "Big Bang" of your project's deployment is resilient, verifiable, and elegant.

## 📜 Version
Current Version: `7.23` (Automaton Edition)

---
Brought to you by the **0xacabOS** Project.
