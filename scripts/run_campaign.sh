#!/usr/bin/env bash
set -euo pipefail

config=${1:?Usage: scripts/run_campaign.sh CONFIG [BATCH]}
batch=${2:-$(date -u +%Y%m%dT%H%M%SZ)}

cd "$(dirname "$0")/../simulations"

out="results/campaigns/$batch/$config"

if [[ -e "$out" ]]; then
    echo "Output already exists: $out. Choose another batch name." >&2
    exit 1
fi

mkdir -p "$out"

git rev-parse HEAD > "$out/commit.txt"
git diff HEAD > "$out/working-tree.patch"
cp campaigns.ini "$out/campaigns.ini"
cp omnetpp.ini "$out/omnetpp.ini"

../src/diffuse \
    -u Cmdenv \
    -n ../src:. \
    -f campaigns.ini \
    -c "$config" \
    --result-dir="$out" \
    --cmdenv-express-mode=true \
    > "$out/run.log" 2>&1

opp_scavetool export \
    -T s \
    -F CSV-R \
    -o "$out/scalars.csv" \
    "$out"/*.sca

printf 'Finished: %s\n' "$out"
