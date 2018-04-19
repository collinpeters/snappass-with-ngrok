# snappass-with-ngrok
Runs SnapPass (https://github.com/pinterest/snappass) locally and exposes via a
temporary ngrok so you can share secrets securely in an ephemeral fashion.

Apps like onetimesecret.com are great, but can you really trust any 3rd party!
No, but you can trust yourself (I hope). Any time you want to share a secret
stay away from chat and email, just run the script below and avoid the
headaches.

# Instructions:
1. `./snappass.sh` to start it up
2. The ngrok URL should open in your browser (if supported), otherwise open the link reported
3. Generate a secret and share with someone
4. As soon as they access it, the secret is deleted from SnapPass
5. Type 'shutdown' to tear down the stack

# Manually running
1. `docker-compose up` to start the stack
2. To get the ngrok URL access http://localhost:4040
   OR, use the following one-liner
   curl -s $(docker port snappass_ngrok_1 4040)/api/tunnels | jq '.tunnels[] | select(.proto == "https") | .public_url'
3. Goto the ngrok URL and generate a secret
4. Share with someone
5. As soon as they access it, the secret is deleted from SnapPass
6. Shut down compose and clean up when all done: ctrl-c to stop and `docker-compose rm` to remove containers

# TODO
The secret is still visible in the ngrok admin app. But you created it locally
and control it (plus you typed in the password in the first place) so this is
not too serious. However, it would be even more awesome to get SSL down to the
app level to prevent sniffing.
