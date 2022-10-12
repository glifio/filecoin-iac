#!/usr/bin/env bash

#TODO: add test of snapshot and some logic for saving more than 1 snapshot
#TODO: we don't catch SIGTERM and logic in the container will continue, we need to handle this somehow

set -eou pipefail

timestamp() {
    date '+%F_%T'
}

NAMESPACE='${namespace}'
BLOCKS_TO_EXPORT='${blocks_to_export}'
POD='${pod}'
CONTAINER='filecoin'
CONTAINER='${container}'
CUR_SNAP='/data/ipfs/lotus-current.car'
NEW_SNAP='/data/ipfs/lotus-new.car'
SHELL='${shell}'

run_in_container() {
    kubectl exec $POD -c $CONTAINER -n $NAMESPACE -- $SHELL -c "$1"
}


if [ "$BLOCKS_TO_EXPORT" -lt 900 ]; then
    echo "$(timestamp) - ERROR - BLOCKS_TO_EXPORT variable should be" \
        "greater then 900 due to recent-stateroots limitation"
    exit 1
fi

command='lotus chain list --count 1 --format "<height>"'
current_block=$(run_in_container "$command")
echo "$(timestamp) get current block height is $current_block, found by '$command'"
command="lotus chain export --tipset @$current_block --recent-stateroots $BLOCKS_TO_EXPORT \
    --skip-old-msgs $NEW_SNAP"
echo "$(timestamp) started lotus snapshot export for $BLOCKS_TO_EXPORT blocks via '$command'"
run_in_container "$command"
echo "$(timestamp) finished lotus snapshot export for $BLOCKS_TO_EXPORT blocks via '$command'"
command="mv $NEW_SNAP $CUR_SNAP"
echo "$(timestamp) moving new on old chian_snap via $command"
run_in_container "$command"
