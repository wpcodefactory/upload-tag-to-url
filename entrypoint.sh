#!/bin/sh -l

OWNER="wpcodefactory"
REPO="test-plugin"
TOKEN=$INPUT_TOKEN

JSON_URL=https://api.github.com/repos/$OWNER/$REPO/releases/latest
echo $JSON_URL
/usr/bin/curl -u $TOKEN:x-oauth-basic $JSON_URL > latest.json
/usr/bin/sudo ID=`cat latest.json | jq '.assets[0].id' | tr -d '"'`
echo "ID --> " $ID
URL=https://$TOKEN@api.github.com/repos/$OWNER/$REPO/releases/assets/$ID
/usr/bin/curl -L -H "Accept:application/octet-stream" $URL | tar -xzv --strip-components=1
rm -rf latest.json

