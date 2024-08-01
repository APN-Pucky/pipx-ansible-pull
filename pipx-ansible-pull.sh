#!/bin/bash

usage() {
  echo "Usage: $0 [-U|--url <URL>] [-c|--checkout <CHECKOUT>] [ansible-pull options]"
  exit 1
}


# Check if ANSIBLE_HOME is set, if not, set it to ~/.ansible
# Initialize variables
url=""
checkout=""

# Filter arguments
rest_args=()
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -U|--url)
      if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
        url="$2"
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        usage
      fi
      ;;
    -C|--checkout)
      if [ -n "$2" ] && [ "${2:0:1}" != "-" ]; then
        checkout="@$2"
        shift 2
      else
        echo "Error: Argument for $1 is missing" >&2
        usage
      fi
      ;;
    *)
      rest_args+=("$1")
      shift
      ;;
  esac
done

# Check if URL is set
if [ -z "$url" ]; then
  echo "Error: URL is required"
  usage
fi

# Run ansible-pull with the arguments
pipx run --no-cache --spec git+"$url$checkout" ansible-pull -U "$url" "${rest_args[@]}"


