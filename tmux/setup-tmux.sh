#!/bin/bash

# This script will install (if it is not already) and setup TMUX,
# TPM, and a default config.

install_deps () {
  for dep in "$@"; do
    if command -v $1 &> /dev/null
    then
      echo Dependency $1 is already installed.
      return
    fi
    
    echo Installing $1...
    case "$(uname -s)" in
      Linux*)
        sudo apt-get install $1 -y
        ;;
      Darwin*)
        brew install $1
        ;;
      *)
        echo Currently unsupported system: "$(uname -s)"
        echo Exiting...
        exit 1
        ;;
    esac
    echo Install Complete.
  done
}

# List of dependencies:
deps=(
  tmux
)

# Install Dependencies
echo Checking Dependencies: ${deps[@]}
install_deps ${deps[@]}

# Grab Conf
echo Grabbing Oh My Tmux configuration...
git clone https://github.com/gpakosz/.tmux.git ${HOME}/Programs/.tmux
ln -s -f ${HOME}/Programs/.tmux/.tmux.conf ${HOME}

# Get TPM
echo Getting TPM...
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy Local Conf
echo Copy local configuration...
cp .tmux.conf.local ${HOME}/.

echo Done!
