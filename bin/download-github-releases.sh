#!/bin/bash
set -e

print_usage() {
    echo "Usage: download-github-releases.sh [-t] <github_personal_access_token> <list of urls of github releases>"
    echo "       First parameter <github_personal_access_token> is optional"
    echo "       If flag -t is set, the app remains stored in an archive and is not unpacked"
}

# parse opts
UNTAR_ARCHIVE=1
while getopts 't' OPTION; do
  case "$OPTION" in
    t)
      UNTAR_ARCHIVE=0
      ;;
    ?)
      print_usage
      exit 2
      ;;
  esac
done
shift "$(($OPTIND -1))"

# parse args
if [ "$#" -eq 2 ]; then
    # personal access token is given
    GITHUB_PAT=$1
    AUTH="Authorization: token ${GITHUB_PAT}"
    GITHUB_RELEASES=$2
elif [ "$#" -eq 1 ]; then
    GITHUB_RELEASES=$1
else
    print_usage
    exit 2
fi

# Download apps from Github releases
for RELEASE in ${GITHUB_RELEASES}; do
    echo "Downloading assets from ${RELEASE}"
    RESPONSE=$(curl -sH "${AUTH}" "${RELEASE}")
    COUNT=$(echo "${RESPONSE}" | jq '.assets | length')
    if [ $COUNT -eq 0 ]; then
        echo $RESPONSE
        exit 2
    fi
    for i in $(seq 1 ${COUNT}); do
        URL=$(echo "${RESPONSE}" | jq -r .assets[$((${i} - 1))].url)
        echo "Download asset ${i} from ${URL}"
        curl -LJO -H 'Accept: application/octet-stream' -H "${AUTH}" "${URL}"
    done
done

# Untar apps
if [ $UNTAR_ARCHIVE -eq 1 ]; then
    for f in *.tgz; do
        if [ -f "$f" ]; then
            tar xzf "$f"
            rm -f "$f"
        fi
    done
    for f in *.tar.gz; do
        if [ -f "$f" ]; then
            tar xzf "$f"
            rm -f "$f"
        fi
    done
fi