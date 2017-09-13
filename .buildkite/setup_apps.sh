#!/bin/sh


echo $PWD
pushd ../
  # make sure there are no hanging servers from previous build
  fuser -k -n tcp 3000
  fuser -k -n tcp 3002
  # "[[ ! -d \"buildkite-demo-client\" ]] && git clone git@github.com:adorableio/buildkite-demo-client.git"
  # "[[ ! -d \"buildkite-demo-server\" ]] && git clone git@github.com:adorableio/buildkite-demo-server.git"
  # (cd buildkite-demo-client && npm install)
  # (cd buildkite-demo-server && npm install)
popd
