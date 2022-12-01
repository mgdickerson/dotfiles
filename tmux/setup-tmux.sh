#!/bin/bash

# This script will install (if it is not already) and setup TMUX,
# TPM, and a default config.

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*)   machine=linux;;
  Darwin*)  machine=macOS;;
  *)        machine=unknown;;
esac

echo ${machine}

if [[ $OSTYPE == 'darwin'* ]]; then
  echo 'macOS'
fi


# Setup script for tmux (assuming TMUX is installed):
if ! command -v tmux &> /dev/null
then
  echo "tmux not installed, install tmux."
  exit
fi
