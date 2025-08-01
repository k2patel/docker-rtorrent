#!/usr/bin/env bash
set -e

CLEANUP_FILE="/home/nfs_download/rsession/rtorrent.lock"

# Remove stale lock at startup
if [ -f "$CLEANUP_FILE" ]; then
  echo "️Stale lock file found. Removing..."
  rm -f "$CLEANUP_FILE"
fi

cleanup() {
  echo "Caught shutdown signal. Cleaning up..."
  rm -f "$CLEANUP_FILE"
  echo "Cleanup complete."
}

trap cleanup INT TERM EXIT

echo "Starting rtorrent..."

exec rtorrent