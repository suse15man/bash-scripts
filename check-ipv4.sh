#!/usr/bin/env bash
# Check IPv4 address

# function to check IPv4 address
check_ipv4_address() {
  if [ -n "$1" -a -z "${*##*\.*}" ]; then
    ipcalc $1 | \
      awk 'BEGIN{FS=":";is_invalid=0} /^INVALID/ {is_invalid=1; print $1} END{exit is_invalid}'
  else
    echo "EMPTY OR INVALID ADDRESS"
    return 125
  fi
}

# shell script requires exactly one parameter
if [ "$#" -ne "1" ]; then
  exit
fi

# param
parameter="$1"

# function output and exit code
check_output=$(check_ipv4_address $parameter)
check_exit_code=$(echo $?)

if [ "$check_exit_code" -eq "0" ]; then
  echo "IPv4 address is valid"
else
  echo "IPv4 address is invalid"
  echo $check_output
fi
