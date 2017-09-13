#!/bin/sh

# run the server in the background
npm start &
NPM_SERVER_PID="$!"

# wait for port 3000 to be bound
while ! nc localhost 3000; do
  sleep 1
done

# wait for port 3002 to be bound
while ! nc localhost 3002; do
  sleep 1
done

echo "server started"
$(npm bin)/cypress run
