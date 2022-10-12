#!/usr/bin/env bash

# TODO: built our own container with tools like kubectl, git, whatever else
#TODO: we don't catch SIGTERM and logic in the container will continue, we need to handle this somehow

set -eou pipefail

timestamp() {
    date '+%F_%T'
}

NAMESPACE='${namespace}'
POD='${pod}'
CONTAINER='${container}'
FILE_STORE_SNAP_NAME='${file_to_store_id}'
SHELL='${shell}'
REPO='${git_repo}'
AUTHOR_NAME='${git_author}'
AUTHOR_EMAIL='${git_email}'

run_in_container() {
    kubectl exec $POD -c $CONTAINER -n $NAMESPACE -- $SHELL -c "$1"
}

command="if [ -f $FILE_STORE_SNAP_NAME ]; then cat $FILE_STORE_SNAP_NAME; else exit 1; fi;"
echo "$(timestamp) checking that ipfs_id in file exist via '$command'"
ipfs_id=$(run_in_container "$command")
echo "$(timestamp) ipfs_id is $ipfs_id"

echo "$(timestamp) installing git and ssh-keyscan from openssh-client"
apt update 1>/dev/null 2>&1 -y && apt install git openssh-client -y 1>/dev/null 2>&1

echo "$(timestamp) fetching gist.github.com SSH keys"
# TODO: consider use -o UserKnownHostsFile in the ssh command
mkdir -p /root/.ssh
ssh-keyscan -t rsa gist.github.com >> /root/.ssh/known_hosts
echo "$(timestamp) cloning repo $REPO"
git clone "$REPO" /tmp/snapshots
echo "$(timestamp) adding ipfs_id data"
echo "$ipfs_id" > /tmp/snapshots/snapshot.log
echo "$(timestamp) going to /tmp/snapshots"
cd /tmp/snapshots &&
echo "$(timestamp) configuring git"
git config user.name "$AUTHOR_NAME"
git config user.email "$AUTHOR_EMAIL"
echo "$(timestamp) committing data"
git commit --allow-empty -a -m "new export"
echo "$(timestamp) pushing data..."
git push
