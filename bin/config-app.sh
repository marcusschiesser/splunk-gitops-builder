#!/bin/bash
# Usage: ./config_app.sh <APP> <CONFIG_FOLDER>
# Extracts the <APP> tarball, copies the configuration of <CONFIG_FOLDER> over and
# creates a new tarball with the extension `patched.tgz`
set -e

WORKDIR=$(pwd -P)
APP=$1
CONFIG=$2

pushd /tmp
rm -fr splunk_config
mkdir splunk_config
cd splunk_config
tar xzf "$WORKDIR/$APP"
cp -R "$WORKDIR/$CONFIG" .
tar czf "$WORKDIR/${APP%.*}.patched.tgz" .
rm -fr splunk_config
popd
