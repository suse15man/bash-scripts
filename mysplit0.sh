#!/usr/bin/env bash

for i in my.obi.*;do
	awk -F'|' '{print $1 $2 $3 $4 $5}' $i
	awk -F'|' '{print $NF}' $i |sed 's/ Changes: //' > my.temp.obi.txt
	jq < my.temp.obi.txt
done
