#!/bin/sh

source ".buildkite/shared_functions"

function prepare_app() {
  # If the directory doesn't exist, clone it
  [[ ! -d "$1" ]] && git clone git@github.com:adorableio/$1.git

  local BRANCH_OR_SHA="master"
  pushd $1
    if [ "$1" = "$TRIGGERING_REPO" ]; then
      [[ -z "$TRIGGERING_SHA" ]] && BRANCH_OR_SHA=$TRIGGERING_SHA
    fi
    git checkout .
    git checkout $BRANCH_OR_SHA
    git pull
    npm install
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
