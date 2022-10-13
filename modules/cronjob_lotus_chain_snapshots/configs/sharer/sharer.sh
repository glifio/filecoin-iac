#!/usr/bin/env bash

#TODO: we don't catch SIGTERM and logic in the container will continue, we need to handle this somehow

set -eou pipefail

timestamp() {
    date '+%F_%T'
}

NAMESPACE='${namespace}'
POD='${pod}'
CONTAINER='${container}'
CUR_SNAP='${cur_snap}'
FILE_STORE_SNAP_NAME='${file_to_store_id}'
SHELL='${shell}'

run_in_container() {
    kubectl exec $POD -c $CONTAINER -n $NAMESPACE -- $SHELL -c "$1"
}

command="[ -s $CUR_SNAP ]"
echo "$(timestamp) checking that chain_snap exist via '$command'"
run_in_container "$command"

command='ipfs pin ls --quiet --type recursive | xargs ipfs pin rm && ipfs repo gc --silent'
echo "$(timestamp) clean up old chain snapshot from ipfs via '$command'"
run_in_container "$command"

command="ipfs add $CUR_SNAP --quiet"
echo "$(timestamp) add chain_snap to ipfs via '$command'"
run_in_container "$command"

command="ipfs pin ls --quiet --type recursive > $FILE_STORE_SNAP_NAME"
echo "$(timestamp) store ipfs_id for gitter container in the file on the disk via '$command'"
run_in_container "$command"
