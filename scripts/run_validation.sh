#!/bin/bash
# Runs the validation suite V1-V7 in Cmdenv and prints one summary line per run.
# Usage, from the repository root, after `source ~/omnetpp-6.3.0/setenv` and `make`:
#   scripts/run_validation.sh            # all validation configs
#   scripts/run_validation.sh V4_Ring4   # selected configs only
# Compare the output with the Expected column in tests/validation_results.md.

set -e
cd "$(dirname "$0")/../simulations"

configs=("$@")
if [ ${#configs[@]} -eq 0 ]; then
    configs=(V1_Single V2_Line6 V3_Tree7 V4_Ring4 V5_Cyclic6 V6_Line6Initiators V7_Gaps)
fi

for c in "${configs[@]}"; do
    rm -rf "results/$c"
    ../src/diffuse -u Cmdenv -n ../src:. -c "$c" --cmdenv-express-mode=true > /dev/null
    echo "== $c"
    ../scripts/summary.sh "$c"
done
