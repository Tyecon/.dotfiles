#!/bin/bash
if [ -z "$1" ]; then
  echo "ERROR: Missing system configuration name."
  echo "Usage: $0 <vm|desktop|laptop|nas>"
  exit 1
fi

CONFIG_NAME="$1"
CONFIG_ROOT=$(pwd)/../..
CONFIG_FILE="$CONFIG_ROOT/config/systems/${CONFIG_NAME}.scm"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "ERROR: Configuration file not found at: $CONFIG_FILE"
  echo "Check if the system exists in ${CONFIG_ROOT}/config/systems"
  exit 1
fi

echo "Reconfiguring System..."
echo "Target System: $CONFIG_NAME"
echo "Config File:   $CONFIG_FILE"
echo "Load Path:     $CONFIG_ROOT"

sudo guix system reconfigure "$CONFIG_FILE" --load-path="$CONFIG_ROOT"
echo "Reconfiguration finished."
