#!/bin/sh


function kill_port() {
  lsof -i tcp:${1} | awk 'NR!=1 {print $2}' | xargs kill
}

function prepare_app() {
  # If the directory doesn't exist, clone it
  [[ ! -d "$1" ]] && git clone git@github.com:adorableio/$1.git

  local BRANCH="master"
  pushd $1
    if [ $1 = $CURRENT_APP ]; then
      [[ -z "$CURRENT_SHA" ]] && BRANCH=$CURRENT_SHA
    fi
    git checkout .
    git checkout $BRANCH
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
