#!/usr/bin/env bash

### to copy this tool to all callp0 nodes:
### ansible callps -m copy -a "src=bf.dTerminal.sh dest=~aaw mode=500 owner=aaw group=nciadmin"
### to use this as remote ssh -tt:
### ssh -tt itt99cp0n0 "~/bf.dTerminal.sh 08000fca4967"

### usage:
if [ $# -ne 1 ];then
	echo "Usage: $0 <mac-address>"
	exit 1
fi

### check for valid mac address without colons:
if [[ $1 =~ ^([0-9a-fA-F]{2}){5}[0-9a-fA-F]{2}$ ]];then
	echo "valid mac address"
else
	echo "invalid mac address"
	exit 2
fi

timeout 2s curl telnet://localhost:4000 <<EOF
import bf;reload(bf);bf.dTerminal('${1}_0')
EOF
