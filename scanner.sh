#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <IP address> <start port> <end port>" >&2
  exit 1
fi

ip=$1
start=$2
end=$3

function portscan() {
  # for p in {$start..$end}; do
  for p in $(seq $start $end); do
    printf "%06d\r" $p
    bash -c "(>/dev/tcp/$ip/$p)" 2> /dev/null && echo open: $p &
    read -t0.7
    kill $! &>/dev/null
  done
}

portscan
