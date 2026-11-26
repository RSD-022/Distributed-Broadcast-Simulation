#!/usr/bin/env bash
# Exports one campaign to CSV-S for the evaluation (Step 8).
# Usage:   scripts/export_results.sh CONFIG [BATCH]
# Example: scripts/export_results.sh C4_Loss campaign-02
# Output:  results/processed/CONFIG.csv
set -euo pipefail
shopt -s nullglob

config=${1:?Usage: scripts/export_results.sh CONFIG [BATCH]}
batch=${2:-}

cd "$(dirname "$0")/.."
raw_dir=simulations/results
if [[ -n "$batch" ]]; then
    source_dir="$raw_dir/campaigns/$batch/$config"
else
    source_dir="$raw_dir/$config"
    direct_scalars=("$source_dir"/*.sca)
    if (( ${#direct_scalars[@]} == 0 )); then
        batch_scalars=("$raw_dir"/campaigns/*/"$config"/*.sca)
        if (( ${#batch_scalars[@]} > 0 )); then
            source_dir=${batch_scalars[0]%/*}
            for file in "${batch_scalars[@]}"; do
                if [[ "${file%/*}" != "$source_dir" ]]; then
                    printf 'Multiple batches contain %s. Run scripts/export_results.sh %s BATCH.\n' "$config" "$config" >&2
                    exit 2
                fi
            done
        fi
    fi
fi

scalar_files=("$source_dir"/*.sca)
if (( ${#scalar_files[@]} == 0 )); then
    printf 'No .sca files in %s. Run %s first or check the batch name.\n' "$source_dir" "$config" >&2
    exit 1
fi

if ! command -v opp_scavetool >/dev/null; then
    echo 'opp_scavetool is missing. Source your OMNeT++ setenv and retry.' >&2
    exit 1
fi

output_dir=results/processed
output="$output_dir/$config.csv"
mkdir -p "$output_dir"
temporary_csv=$(mktemp "$output_dir/.${config}.XXXXXX")
trap 'rm -f -- "$temporary_csv"' EXIT

opp_scavetool export -T s -F CSV-S -o "$temporary_csv" "${scalar_files[@]}"
mv -f -- "$temporary_csv" "$output"
printf 'Exported %s from %s\n' "$output" "$source_dir"
