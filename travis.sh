#!/bin/bash
# Demyx
# https://demyx.sh

# Get versions
DEMYX_CODE_DEBIAN_VERSION="$(docker exec "$DEMYX_REPOSITORY" cat /etc/debian_version | sed 's/\r//g')"
DEMYX_CODE_VERSION="$(docker exec "$DEMYX_REPOSITORY" cat --version | awk -F '[ ]' '{print $1}' | awk '{line=$0} END{print line}' | sed 's/\r//g')"
DEMYX_CODE_GO_VERSION="$(docker run --rm --entrypoint=go demyx/"$DEMYX_REPOSITORY":go version | awk -F '[ ]' '{print $3}' | sed 's/go//g' | sed 's/\r//g')"

# Replace versions
# tag-bedrock
sed -i "s|debian-.*.-informational|debian-${DEMYX_CODE_DEBIAN_VERSION}-informational|g" tag-bedrock/README.md
sed -i "s|code--server-.*.-informational|code--server-${DEMYX_CODE_VERSION}-informational|g" tag-bedrock/README.md
# tag-latest
sed -i "s|debian-.*.-informational|debian-${DEMYX_CODE_DEBIAN_VERSION}-informational|g" README.md
sed -i "s|code--server-.*.-informational|code--server-${DEMYX_CODE_VERSION}-informational|g" README.md
sed -i "s|go-.*.-informational|go-${DEMYX_CODE_GO_VERSION}-informational|g" README.md
# tag-wp
sed -i "s|debian-.*.-informational|debian-${DEMYX_CODE_DEBIAN_VERSION}-informational|g" tag-wp/README.md
sed -i "s|code--server-.*.-informational|code--server-${DEMYX_CODE_VERSION}-informational|g" tag-wp/README.md

# Echo versions to file
echo "DEMYX_CODE_DEBIAN_VERSION=$DEMYX_CODE_DEBIAN_VERSION
DEMYX_CODE_VERSION=$DEMYX_CODE_VERSION
DEMYX_CODE_GO_VERSION=$DEMYX_CODE_GO_VERSION" > VERSION

# Push back to GitHub
git config --global user.email "travis@travis-ci.com"
git config --global user.name "Travis CI"
git remote set-url origin https://"$DEMYX_GITHUB_TOKEN"@github.com/demyxco/"$DEMYX_REPOSITORY".git
# Commit VERSION file first
git add VERSION
git commit -m "DEBIAN $DEMYX_CODE_DEBIAN_VERSION, CODE-SERVER $DEMYX_CODE_VERSION, GO $DEMYX_CODE_GO_VERSION"
git push origin HEAD:master
# Add and commit the rest
git add .
git commit -m "Travis Build $TRAVIS_BUILD_NUMBER"
git push origin HEAD:master

# Set the default path to README.md
README_FILEPATH="./README.md"

# Acquire a token for the Docker Hub API
echo "Acquiring token"
TOKEN="$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'$DEMYX_USERNAME'", "password": "'$DEMYX_PASSWORD'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)"

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
