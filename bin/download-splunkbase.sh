#!/bin/bash
set -e

if [ "$#" -ne 3 ]; then
    echo "Usage: download-splunkbase.sh <splunkbase_username> <splunkbase_password> <list of app definitions>"
    exit 1
fi

SPLUNKBASE_USERNAME=$1
SPLUNKBASE_PASSWORD=$2
SPLUNKBASE_APPS=$3

# download multiple apps
for APP in ${SPLUNKBASE_APPS}; do \
      download-splunkbase.py "${SPLUNKBASE_USERNAME}" "${SPLUNKBASE_PASSWORD}" "${APP}"; \
done

# Untar apps
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
