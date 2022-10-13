URL=$(curl -ssN "$1" | grep -oE "cdn.+iso")
echo https://$URL