#!/bin/bash
set -e

# create tar balls for all apps (with configurations) so they can be used by SPLUNK_APPS_URL
for app in *; do \
      tar czf "$app.tgz" "$app"; \
      rm -rf "$app"; \
done
    