#!/bin/bash

# Function to display usage instructions
usage() {
  echo "Usage: co [-b branch] [-d destination] <reponame>"
  exit 1
}

# Parse options
while getopts "b:d:" opt; do
  case $opt in
    b)
      BRANCH="$OPTARG"
      ;;
    d)
      DESTINATION="$OPTARG"
      ;;
    *)
      usage
      ;;
  esac
done

# Shift arguments to exclude parsed options
shift $((OPTIND-1))

# Check if the provided argument is not empty
if [ -z "$1" ]; then
  usage
fi

REPO_NAME="$1"
CONFIG_FILE="$HOME/.config/co.conf"

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Configuration file not found at $CONFIG_FILE"
  exit 1
fi

# Read GitHub organizations from the configuration file
GITHUB_ORGS=$(cat "$CONFIG_FILE" | grep -v '^#' | grep -v '^$')

# Set git clone options
CLONE_OPTIONS=""
if [ ! -z "$BRANCH" ]; then
  CLONE_OPTIONS="$CLONE_OPTIONS -b $BRANCH"
fi

if [ ! -z "$DESTINATION" ]; then
  CLONE_OPTIONS="$CLONE_OPTIONS $DESTINATION"
fi

# Loop through the organizations and try to clone the repository
for ORG in $GITHUB_ORGS; do
  echo "Trying to clone from organization: $ORG"
  git clone $CLONE_OPTIONS "git@github.com:$ORG/$REPO_NAME.git" && exit 0
done

echo "Error: Repository not found in the configured organizations."
exit 1
