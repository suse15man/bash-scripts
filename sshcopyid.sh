#!/usr/bin/env bash

date
###for j in {sil,bvn,itt};do
###	echo $j
###	for i in $(grep -v '###' /etc/hosts|awk -v myvar=\"$j\" '/myvar/{print $2}');do echo $i;ssh-copy-id $i;done
###done
for i in $(awk '/itt.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh-copy-id $i;done
for i in $(awk '/sil.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh-copy-id $i;done
for i in $(awk '/bvn.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh-copy-id $i;done
date
