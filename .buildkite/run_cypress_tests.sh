#!/bin/sh

function wait_for_port() {
  local port="$1"
  while lsof -i tcp:"${port}" > /dev/null; do
    echo "waiting for ${port}"
    sleep 1
  done
}

echo "starting servers in background..."
npm start &

echo "waiting for servers to start..."
wait_for_port 3000
wait_for_port 3002

echo "servers started, running tests..."
npm run test
