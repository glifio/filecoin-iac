#!/usr/bin/env bash

set -eou pipefail

timestamp() {
    date '+%F_%T'
}

NAMESPACE="${namespace}"
STS_NAME="${sts_name}"
SNAPS_TO_KEEP="${snaps_to_keep}"

echo "$(timestamp) looking for snapshots with name $STS_NAME in $NAMESPACE namespace"
# This shell pipe is doing following things:
# 1. Get all volumesnapshots in the namespace
# 2. Filter for statefull set name and get only the column with names
# 3. Get the names of all snapshots except last SNAPS_TO_KEEP snaps, will return empty string if snaps count less or
#   equal to SNAPS_TO_KEEP
snaps_to_del=$(kubectl get --sort-by .metadata.creationTimestamp -n "$NAMESPACE" --no-headers volumesnapshots |
    awk "/$STS_NAME/{print \$1}" |
    head -n -"$SNAPS_TO_KEEP")
snaps_count=$(echo "$snaps_to_del" | wc -l)

if [ -n "$snaps_to_del" ]; then
    echo "$(timestamp) there are $snaps_count snaps to delete, only $SNAPS_TO_KEEP recent snaps will be keeped"
    for snap in $snaps_to_del; do
        echo -n "$(timestamp) "
        kubectl delete volumesnapshots "$snap" -n "$NAMESPACE"
    done
else
    echo "$(timestamp) there is nothing to do, number of snaps is less or equal to number of retained snaps - $SNAPS_TO_KEEP"
fi
