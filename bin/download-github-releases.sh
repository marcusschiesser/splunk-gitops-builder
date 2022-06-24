#!/bin/bash
set -e

if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    echo "Usage: download-github-releases.sh <github_personal_access_token> <list of urls of github releases>"
    echo "       First parameter <github_personal_access_token> is optional"
    exit 1
fi

if [ "$#" -eq 2 ]; then
    # personal access token is given
    GITHUB_PAT=$1
    AUTH="Authorization: token ${GITHUB_PAT}"
    GITHUB_RELEASES=$2
else
    GITHUB_RELEASES=$1
fi

# Download apps from Github releases
for RELEASE in ${GITHUB_RELEASES}; do
    echo "Downloading ${RELEASE}"
    URL=$(curl -sH "${AUTH}" "${RELEASE}" | jq -r .assets[0].url)
    curl -LJO -H 'Accept: application/octet-stream' -H "${AUTH}" "${URL}"
done

# Untar apps
for f in *.tgz; do
    tar xzf "$f"
    rm -f "$f"
done
