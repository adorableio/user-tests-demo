#!/bin/sh

source ".buildkite/shared_functions"

function prepare_app() {
  # If the directory doesn't exist, clone it
  [[ ! -d "$1" ]] && git clone git@github.com:adorableio/$1.git

  local BRANCH_OR_SHA="master"
  pushd $1
    if [ "$1" = "$TRIGGERING_REPO" ]; then
    echo "\n#################################################"
    echo "repo-name: ${1}"
    echo "triggered-repo: ${TRIGGERING_SHA}"
      [[ -n "$TRIGGERING_SHA" ]] && BRANCH_OR_SHA=$TRIGGERING_SHA
      echo "branch-or-sha: ${BRANCH_OR_SHA}"
    fi
    git checkout .
    git fetch -a
    echo "\nchecking out ${BRANCH_OR_SHA}"
    git checkout $BRANCH_OR_SHA
    echo "pulling latest"
    git pull
    npm install
    echo "#################################################\n"
  popd
}

echo $PWD
pushd ../
  # make sure there are no hanging servers from previous build
  kill_port 3000
  kill_port 3002
  prepare_app buildkite-demo-client
  prepare_app buildkite-demo-server
popd
