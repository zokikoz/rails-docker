#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /var/www/app/tmp/pids/server.pid

# Exec container's main process CMD
exec "$@"
