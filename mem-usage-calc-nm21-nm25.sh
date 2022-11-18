#!/usr/bin/env bash

date;for i in $(awk '/nm2[1|5]node/{print $NF}' /etc/hosts);do  echo $i; ssh cvadmin@$i free -k|awk '/Mem:/{print $4, $6, $7}';done
