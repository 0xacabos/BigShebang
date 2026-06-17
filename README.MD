# BigShebang 🌌

**The seed that carries its own soil.**

BigShebang is a high-fidelity, self-extracting **Distribution Automaton**. It creates portable "vessels" that contain entire directory structures, preserving every nuance of the original environment (permissions, symlinks, xattrs) and ensuring absolute fidelity upon seeding.

Implemented as a deterministic **State Machine Automaton** within a single Bash script, BigShebang is the primary distribution engine for the **0xacabOS** ecosystem.

---

## 🛠 Features

- **Automaton Architecture:** Orchestrated as a formal state machine for deterministic resilience and absolute reliability.
- **Binary Tail Extraction:** High-performance payload delivery. The distribution vessel is appended directly to the script tail and unfolded with byte-level precision.
- **Cryptographic Provenance:** Every transformation (Archive -> Harden -> Assemble) generates a SHA-256 signature, creating a verifiable chain of custody.
- **Grimoire Oracle:** A dedicated knowledge layer (`--grimoire`) that speaks the project's intent and holographic manifest to humans and AIs without needing to unfold the vessel.
- **Radical Openness:** Optimized for open distribution. Encryption is a "Hardening" option, not a barrier to transparency.
- **Self-Validating:** Internal self-diagnostic protocol (`--self-test`) ensures the environment is capable of perfect integrity before seeding.
- **Recursive Dream:** The vessel can carry a copy of its own creator (`-R`), ensuring the lineage continues.

## 🔒 Payload Hardening (Optional)

While BigShebang is designed for open distribution, it supports optional **Payload Hardening** for secure transport:
- **Encryption:** AES-256-CBC via OpenSSL.
- **Key Derivation:** PBKDF2 with 100,000 iterations and SHA-512.

## 🚀 Usage

### Create a Distribution Vessel
```bash
./bigshebang [OPTIONS] <source_directory> [vessel_file]
```
**Options:**
- `-c, --compress TYPE` : none, gzip, bzip2, xz, zstd (default: gzip)
- `-e, --encrypt`       : Harden the vessel with encryption
- `-p, --password PASS` : Provide hardening password (implies -e)
- `-R, --recursive`     : Include a copy of `bigshebang` inside the vessel
- `-T, --self-test`    : Run internal self-diagnostic before creation
- `-B, --no-banner`      : Suppress branding output

### Seed a Vessel
```bash
./my_project.vessel.sh -d /path/to/target
```

### Commune with the Grimoire
```bash
./my_project.vessel.sh --grimoire
```

## 🏗 Philosophy

BigShebang treats distribution not as a "transfer," but as a **Seeding**. By moving from procedural logic to a state-machine automaton, we ensure that the "Big Bang" of your project's deployment is resilient, verifiable, and elegant. It is the soil in which your code grows.

## 📜 Version
Current Version: `7.23` (Seeder Edition)

---
Brought to you by the **0xacabOS** Project.
