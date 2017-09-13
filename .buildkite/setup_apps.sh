#!/bin/sh


function kill_port() {
  lsof -i tcp:${1} | awk 'NR!=1 {print $2}' | xargs kill
}

echo $PWD
pushd ../
  kill_port 3000
  kill_port 3002
  # make sure there are no hanging servers from previous build
  # "[[ ! -d \"buildkite-demo-client\" ]] && git clone git@github.com:adorableio/buildkite-demo-client.git"
  # "[[ ! -d \"buildkite-demo-server\" ]] && git clone git@github.com:adorableio/buildkite-demo-server.git"
  # (cd buildkite-demo-client && npm install)
  # (cd buildkite-demo-server && npm install)
popd
