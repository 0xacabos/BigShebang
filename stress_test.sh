#!/usr/bin/env bash
# =============================================================================
# BIGSHEBANG STRESS TEST AUTOMATON
# =============================================================================
# A rigorous validation suite for the BigShebang Secure Automaton.

set -euo pipefail

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

# Test Settings
TEST_ROOT="stress_workspace"
SOURCE_DIR="$TEST_ROOT/source"
EXTRACT_DIR="$TEST_ROOT/extracted"
OUTPUT_DIR="$TEST_ROOT/archives"
BIGSHEBANG="./bigshebang"

# Statistics
TESTS_PASSED=0
TESTS_FAILED=0

# Utility Functions
log_info() { echo -e "${CYAN}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[PASS]${NC} $1"; ((TESTS_PASSED+=1)); }
log_fail() { echo -e "${RED}[FAIL]${NC} $1"; ((TESTS_FAILED+=1)); }
log_header() { echo -e "\n${YELLOW}=== $1 ===${NC}"; }

# 1. Setup Environment
setup_env() {
    log_info "Setting up test environment..."
    rm -rf "$TEST_ROOT"
    mkdir -p "$SOURCE_DIR" "$EXTRACT_DIR" "$OUTPUT_DIR"
}

# 2. Generate "Kitchen Sink" Payload
generate_payload() {
    log_info "Generating 'Kitchen Sink' payload..."
    
    # Weird Filenames
    touch "$SOURCE_DIR/file with spaces.txt"
    touch "$SOURCE_DIR/file'with'quotes.txt"
    touch "$SOURCE_DIR/file\"with\"doublequotes.txt"
    touch "$SOURCE_DIR/file_with_backslashes\\.txt"
    touch "$SOURCE_DIR/file_with_dollar\$.txt"
    touch "$SOURCE_DIR/🚀_emoji_file.txt"
    
    # Deep Nesting
    local deep_path="$SOURCE_DIR"
    for i in {1..20}; do
        deep_path="$deep_path/level_$i"
        mkdir -p "$deep_path"
        echo "Depth level $i" > "$deep_path/data.txt"
    done
    
    # Symlinks and Hardlinks
    echo "original content" > "$SOURCE_DIR/original.txt"
    ln -s "original.txt" "$SOURCE_DIR/rel_symlink.txt"
    ln -s "$(pwd)/$SOURCE_DIR/original.txt" "$SOURCE_DIR/abs_symlink.txt"
    ln "$SOURCE_DIR/original.txt" "$SOURCE_DIR/hardlink.txt"
    
    # Binary Content
    dd if=/dev/urandom of="$SOURCE_DIR/random.bin" bs=1024 count=100 2>/dev/null
    
    # ANSI Banner
    cat > "$SOURCE_DIR/file_id.diz" << 'EOF'
   _____ _             _ 
  / ____| |           | |
 | (___ | |__   ___  | |__   __ _ _ __   __ _ 
  \___ \| '_ \ / _ \ | '_ \ / _` | '_ \ / _` |
  ____) | | | |  __/ | |_) | (_| | | | | (_| |
 |_____/|_| |_|\___| |_.__/ \__,_|_| |_|\__, |
                                         __/ |
                                        |___/ 
EOF
}

# 3. Test Archive and Extraction
test_cycle() {
    local comp="$1"
    local recursive="$2"
    local test_id="comp_${comp}_rec_${recursive}"
    local archive="$OUTPUT_DIR/test_${test_id}.vessel.sh"
    local target="$EXTRACT_DIR/$test_id"
    local password="StressTestPassword123!"
    
    log_info "Cycle: Compression=$comp, Recursive=$recursive"
    
    local flags=("-c" "$comp" "-p" "$password" "-o" "$archive" "-B")
    [[ "$recursive" == "true" ]] && flags+=("-R")
    
    # Create
    if ! $BIGSHEBANG "${flags[@]}" "$SOURCE_DIR" >/dev/null 2>&1; then
        log_fail "$test_id: Archive creation failed"
        return 1
    fi
    
    # Extract
    mkdir -p "$target"
    if ! "$archive" -p "$password" -d "$target" -B >/dev/null 2>&1; then
        log_fail "$test_id: Extraction failed"
        return 1
    fi
    
    # Verify Content
    if ! diff -r "$SOURCE_DIR" "$target/source" >/dev/null 2>&1; then
        log_fail "$test_id: Content mismatch!"
        return 1
    fi
    
    # Verify Recursive
    if [[ "$recursive" == "true" ]]; then
        if [[ ! -f "$target/bigshebang" ]]; then
            log_fail "$test_id: Recursive extractor missing!"
            return 1
        fi
    fi
    
    log_success "$test_id: Integrity verified."
}

# 4. Chaos Monkey Tests
test_chaos() {
    log_header "Chaos Monkey: Failure Injection"
    
    local archive="$OUTPUT_DIR/chaos_base.vessel.sh"
    local password="chaos"
    $BIGSHEBANG -c gzip -p "$password" -o "$archive" -B "$SOURCE_DIR" >/dev/null 2>&1
    
    # Test 1: Wrong Password
    if "$archive" -p "wrong_pass" -d "$EXTRACT_DIR/wrong" -B >/dev/null 2>&1; then
        log_fail "Chaos: Accepted wrong password!"
    else
        log_success "Chaos: Rejected wrong password."
    fi
    
    # Test 2: Bit Corruption
    local corrupt_archive="$OUTPUT_DIR/corrupt.vessel.sh"
    cp "$archive" "$corrupt_archive"
    # Find the payload (approx 10KB in for the script header) and flip a bit
    # We'll just overwrite a byte at the end of the file
    printf "\x00" | dd of="$corrupt_archive" bs=1 seek=$(( $(wc -c < "$corrupt_archive") - 10 )) conv=notrunc 2>/dev/null
    
    if "$corrupt_archive" -p "$password" -d "$EXTRACT_DIR/corrupt" -B >/dev/null 2>&1; then
        log_fail "Chaos: Did not detect bit corruption!"
    else
        log_success "Chaos: Detected corruption via SHA-256."
    fi
}

# Main Execution
main() {
    log_header "Initializing Stress Test Automaton"
    setup_env
    generate_payload
    
    log_header "Phase 1: Compression Permutations"
    for c in none gzip bzip2 xz zstd; do
        test_cycle "$c" "false"
    done
    
    log_header "Phase 2: Encryption States"
    # Test 1: Explicit Encryption
    test_cycle "gzip" "false"
    # Test 2: Passwordless (new default)
    log_info "Cycle: Encryption=none (Default)"
    local archive="$OUTPUT_DIR/test_passwordless.vessel.sh"
    local target="$EXTRACT_DIR/passwordless"
    if ! $BIGSHEBANG -o "$archive" -B "$SOURCE_DIR" >/dev/null 2>&1; then
        log_fail "Passwordless: Archive creation failed"
    elif ! "$archive" -d "$target" -B >/dev/null 2>&1; then
        log_fail "Passwordless: Extraction failed"
    elif ! diff -r "$SOURCE_DIR" "$target/source" >/dev/null 2>&1; then
        log_fail "Passwordless: Content mismatch!"
    else
        log_success "Passwordless: Integrity verified."
    fi

    log_header "Phase 3: Recursive Capabilities"
    test_cycle "gzip" "true"
    
    log_header "Phase 3: Security Hardening"
    test_chaos
    
    log_header "Stress Test Summary"
    echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
    echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
    
    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "\n${GREEN}STATUS: ROCK-SOLID${NC}"
        exit 0
    else
        echo -e "\n${RED}STATUS: VULNERABLE${NC}"
        exit 1
    fi
}

main
