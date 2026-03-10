#!/bin/bash
set -e

# Usage:
#   ./run_unit_tests.sh [test_type]
#
# Arguments:
#   test_type: Optional. The type of tests to run. 
#              Values: 'unit' (default), 'integration', 'all'
#
# Examples:
#   ./run_unit_tests.sh              # Runs unit tests (default)
#   ./run_unit_tests.sh unit         # Runs unit tests
#   ./run_unit_tests.sh integration  # Runs integration tests
#   ./run_unit_tests.sh all          # Runs all tests


# Parse the first argument to determine which tests to run
# Options: unit (default), integration, all
TEST_TYPE=${1:-unit}
ARGS=""

if [ "$TEST_TYPE" == "unit" ]; then
  ARGS="--exclude-tags=integration"
elif [ "$TEST_TYPE" == "integration" ]; then
  ARGS="--tags=integration"
elif [ "$TEST_TYPE" == "all" ]; then
  ARGS=""
else
  echo "Error: Invalid argument '$TEST_TYPE'. Usage: $0 [unit|integration|all]"
  exit 1
fi

# Define the base directory relative to the script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to run tests in a directory
run_tests() {
  local dir="$1"
  local cmd="$2"
  echo "----------------------------------------------------------------"
  echo "Running $TEST_TYPE tests in $dir..."
  echo "----------------------------------------------------------------"
  cd "$SCRIPT_DIR/../$dir" || exit 1
  
  if [ "$cmd" == "flutter" ]; then
    flutter test $ARGS
  else
    if [ -d "test" ]; then
        dart test $ARGS
    else 
        echo "No 'test' directory found in $dir. Skipping tests."
    fi
  fi
}

run_tests "eval_explorer_shared" "dart"
run_tests "eval_explorer_server" "dart"
run_tests "eval_explorer_flutter" "flutter"

echo "----------------------------------------------------------------"
echo "All $TEST_TYPE tests passed successfully!"
echo "----------------------------------------------------------------"
