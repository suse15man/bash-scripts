#!/usr/bin/env bash

# set the right permissions for ~nciadmin:
###for i in $(awk '/itt.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh -tt $i "su -c 'setfacl -m u:aaw:rwx ~nciadmin'";done

# bash all --list-hosts:
# check if process is running with pgrep -f 'python iologger.py' on SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh $i "pgrep -f 'python iologger.py'";done
# kill process running with pkill -f 'python iologger.py' on SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;scp *-iologger-py* $i:~;done
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh -tt $i "su -c '~aaw/kill-iologger-py.sh'";done
# check if process is running with pgrep -f 'python iologger.py' on SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh $i "pgrep -f 'python iologger.py'";done
# change ownership of iologger* to nciadmin on SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh -tt $i "cd ~nciadmin;su -c 'chown -Rv nciadmin: iologger*'";done
# copy the new iologger.zip to SIL 22-31 via bash:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh -tt $i "cd ~nciadmin;su -c 'chown -v aaw: iologger.zip'";done
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;scp iologger.zip ${i}:~nciadmin;done
# change ownership of iologger.zip to nciadmin on SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh -tt $i "cd ~nciadmin;su -c 'chown -v nciadmin: iologger.zip'";done
# unzip the iologger.zip on ~nciadmin as user nciadmin for SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh -tt $i "cd ~nciadmin;su nciadmin -c 'unzip -o iologger.zip'";done
# cleanup the iologger/logs folders on SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh -tt $i "cd ~nciadmin/iologger/logs;su nciadmin -c 'rm -fv iolog*'";done
# restart the python iologger script in the backgroud on SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh $i "cd ~nciadmin/iologger;su -c 'nohup ~aaw/restart-iologger-py.sh >/dev/null 2>&1 &'";done
# check if process is running with pgrep -f 'bash /home/aaw/restart-iologger-py.sh' on SIL 22-31:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh $i "pgrep -f 'bash /home/aaw/restart-iologger-py.sh'";done
# check to see if the logs are being written on SIL 22-31 via bash:
date;for i in $(< ~aaw/iologger10+28+99);do echo $i;ssh $i "cd ~nciadmin/iologger/logs;ls -ltr";done
