#!/bin/sh

# start the stack in the background
echo "Spinning up the stack..."
docker-compose --project-name snappass up -d

sleep 3

# Grab the ngrok URL (requires 'jq')
NGROK_URL=$(curl -s $(docker port snappass_ngrok_1 4040)/api/tunnels | jq -r '.tunnels[] | select(.proto == "https") | .public_url')
echo "\nAccess SnapPass at: $NGROK_URL\n"

# Open URL in browser if we can
if [ -x "$(command -v xdg-open)" ]; then
	xdg-open $NGROK_URL
fi

read -p "Pausing here. Once your secret has been received, type 'shutdown' to destroy everything: " INPUT

while [ "$INPUT" != "shutdown" ]; do 
    read -p "Wrong input, expecting 'shutdown'. Try again: " INPUT
done

echo "Tearing down the stack..."
docker-compose --project-name snappass rm --stop --force
