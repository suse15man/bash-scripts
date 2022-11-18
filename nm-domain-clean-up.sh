#!/usr/bin/env bash

### 1st join both files by columns
### pr -tm nm-domain-clean-up-hosts.txt nm-domain-clean-up-ips.txt > nm-domain-clean-up-hosts-ips.txt

### dry run:
### while read i j;do echo $i;echo "ssh -tt cvadmin@${i} script ${j}";done < nm-domain-clean-up-hosts-ips.txt

### another way
### while read i j;do echo "echo $i";echo "ssh cvadmin@${i} /opt/cv/bin/nmstat.pl --query=\"list dmn where dmnAssociatedSwitch=${j}\"";done < nm-domain-clean-up-hosts-ips.txt

while read i j;do 
	echo $i;ssh cvadmin@${i} /opt/cv/bin/nmstat.pl --query=\"list dmn where dmnAssociatedSwitch=${j}\"
done < nm-domain-clean-up-hosts-ips.txt
