#!/bin/zsh

PYTHON_VERSION="3.11.5"  # Change to the version you need
# Ensure pyenv is initialized
if command -v pyenv 1>/dev/null 2>&1; then
else
  echo "pyenv is not installed. Please install pyenv first."
  exit 1
fi
# Check if the desired Python version is installed, if not, install it
if ! pyenv versions --bare | grep -q "^$PYTHON_VERSION$"; then
  echo "Python version $PYTHON_VERSION is not installed. Installing..."
  pyenv install "$PYTHON_VERSION"
fi
pyenv global "$PYTHON_VERSION"
# Check if pip is installed
if ! command -v pip 1>/dev/null 2>&1; then
  echo "pip not found. Installing..."
  sudo apt-get update
  sudo apt-get install -y python3-pip
fi
REQUIREMENTS_FILE="./requirements.txt"
if [[ ! -f "$REQUIREMENTS_FILE" ]]; then
  echo "File $REQUIREMENTS_FILE not found!"
  exit 1
fi
pip install -r "$REQUIREMENTS_FILE"