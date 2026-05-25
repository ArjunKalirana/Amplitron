#!/bin/bash
# tests/scripts/test_setup_dependencies.sh - Unit test for setup_dependencies.sh flag detection

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
SETUP_SCRIPT="$PROJECT_ROOT/scripts/setup_dependencies.sh"

echo "=== Testing setup_dependencies.sh --no-system-deps ==="

# Mock the external directory to avoid actual clones during test
TEMP_EXTERNAL_DIR="/tmp/amplitron_test_external"
mkdir -p "$TEMP_EXTERNAL_DIR"

# Run the script with the flag and capture output
# Note: We need to mock 'git' or just check the output message
# Since we are testing flag detection, we look for the specific skip message

OUTPUT=$(bash "$SETUP_SCRIPT" --no-system-deps 2>&1)

if [[ "$OUTPUT" == *"Skipping system dependency installation (--no-system-deps flag set)."* ]]; then
    echo "SUCCESS: --no-system-deps flag detected and skip message printed."
else
    echo "FAILURE: --no-system-deps flag not detected or skip message missing."
    echo "Output was:"
    echo "$OUTPUT"
    exit 1
fi

echo "=== Test Passed ==="
rm -rf "$TEMP_EXTERNAL_DIR"
