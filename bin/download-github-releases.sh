#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: download-github-releases.sh <github_personal_access_token> <list of urls of github releases>"
    exit 1
fi

GITHUB_PAT=$1
GITHUB_RELEASES=$2

# Download apps from Github releases
for RELEASE in ${GITHUB_RELEASES}; do \
   echo "Downloading ${RELEASE}"
   URL=$(curl -sH "Authorization: token ${GITHUB_PAT}" "${RELEASE}" | jq -r .assets[0].url); \
   curl -LJO -H 'Accept: application/octet-stream' -H "Authorization: token ${GITHUB_PAT}" "${URL}"; \
done

# Untar apps
for f in *.tgz; do \
    tar xzf "$f"; \
    rm -f "$f"; \
done   