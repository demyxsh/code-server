#!/bin/bash
# Demyx
# https://demyx.sh
# https://github.com/peter-evans/dockerhub-description/blob/master/entrypoint.sh
set -euo pipefail
IFS=$'\n\t'

# Get versions
DEMYX_ALPINE_VERSION="$(docker run --rm --entrypoint=cat demyx/code-server:latest-alpine /etc/os-release | grep VERSION_ID | cut -c 12- | sed 's/\r//g')"
DEMYX_CODE_VERSION="$(docker run --rm --entrypoint=code-server demyx/code-server:latest-alpine --version | sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'| head -n1 | sed "s|info  ||g" | sed "s|-|--|g" | sed 's/\r//g')"
DEMYX_DEBIAN_VERSION="$(docker exec demyx_cs cat /etc/os-release | grep VERSION_ID | cut -c 12- | sed 's|"||g' | sed 's/\r//g')"
DEMYX_DEBIAN_CODE_VERSION="$(docker exec demyx_cs code-server --version | sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'| head -n1 | sed "s|info  ||g" | sed "s|-|--|g" | sed 's/\r//g')"

# Replace versions
sed -i "s|alpine-.*.-informational|alpine-${DEMYX_ALPINE_VERSION}-informational|g" README.md
sed -i "s|debian-.*.-informational|debian-${DEMYX_DEBIAN_VERSION}-informational|g" README.md
sed -i "s|code--server-.*.-informational|code--server-${DEMYX_CODE_VERSION}-informational|g" README.md

sed -i "s|debian-.*.-informational|debian-${DEMYX_DEBIAN_VERSION}-informational|g" tag-wp/README.md
sed -i "s|code--server-.*.-informational|code--server-${DEMYX_DEBIAN_CODE_VERSION}-informational|g" tag-wp/README.md

sed -i "s|alpine-.*.-informational|alpine-${DEMYX_ALPINE_VERSION}-informational|g" tag-wp-alpine/README.md
sed -i "s|code--server-.*.-informational|code--server-${DEMYX_CODE_VERSION}-informational|g" tag-wp-alpine/README.md

sed -i "s|debian-.*.-informational|debian-${DEMYX_DEBIAN_VERSION}-informational|g" tag-sage/README.md
sed -i "s|code--server-.*.-informational|code--server-${DEMYX_CODE_VERSION}-informational|g" tag-sage/README.md

sed -i "s|alpine-.*.-informational|alpine-${DEMYX_ALPINE_VERSION}-informational|g" tag-sage-alpine/README.md
sed -i "s|code--server-.*.-informational|code--server-${DEMYX_CODE_VERSION}-informational|g" tag-sage-alpine/README.md

# Push back to GitHub
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git remote set-url origin https://${DEMYX_GITHUB_TOKEN}@github.com/demyxco/"$DEMYX_REPOSITORY".git
git add .; git commit -m "Travis Build $TRAVIS_BUILD_NUMBER"; git push origin HEAD:master

# Set the default path to README.md
README_FILEPATH="./README.md"

# Acquire a token for the Docker Hub API
echo "Acquiring token"
LOGIN_PAYLOAD="{\"username\": \"${DEMYX_USERNAME}\", \"password\": \"${DEMYX_PASSWORD}\"}"
TOKEN="$(curl -s -H "Content-Type: application/json" -X POST -d ${LOGIN_PAYLOAD} https://hub.docker.com/v2/users/login/ | jq -r .token)"

# Send a PATCH request to update the description of the repository
echo "Sending PATCH request"
REPO_URL="https://hub.docker.com/v2/repositories/${DEMYX_USERNAME}/${DEMYX_REPOSITORY}/"
RESPONSE_CODE=$(curl -s --write-out %{response_code} --output /dev/null -H "Authorization: JWT ${TOKEN}" -X PATCH --data-urlencode full_description@${README_FILEPATH} ${REPO_URL})
echo "Received response code: $RESPONSE_CODE"

if [ $RESPONSE_CODE -eq 200 ]; then
  exit 0
else
  exit 1
fi
