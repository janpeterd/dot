link=$(curl -s https://lofigirl.com/ | grep -oaE "https://\www.youtube.com/[a-zA-Z0-9?%-=]*" | head -1)
linkhandler $link
