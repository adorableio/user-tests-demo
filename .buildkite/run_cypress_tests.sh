#!/bin/sh

source ".buildkite/shared_functions"

function wait_for_port() {
  local port="$1"
  while ! nc localhost "${port}"; do
    echo "waiting for ${port}"
    sleep 1
  done
}

# run the server in the background
npm start &
NPM_SERVER_PID="$!"

echo "waiting for servers to start..."
wait_for_port 3000
wait_for_port 3002

echo "servers started, running tests"
npm run test

echo "tests finished, stopping servers"
kill_port 3000
kill_port 3002
kill "${NPM_SERVER_PID}""
