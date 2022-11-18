#!/usr/bin/env bash

# set the right permissions for ~nciadmin:
###for i in $(awk '/itt.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh -tt $i "su -c 'setfacl -m u:aaw:rwx ~nciadmin'";done

# ansible all --list-hosts:
# check if process is running with pgrep -f 'python iologger.py' on SIL 1-8:
date;ansible iologger1_8 -m shell -a "pgrep -f 'python iologger.py'"
# kill process running with pkill -f 'python iologger.py' on SIL 1-8:
date;for i in $(ansible iologger1_8 --list-hosts|grep bvn);do echo $i;ssh -tt $i "su -c '~aaw/kill-iologger-py.sh'";done
# check if process is running with pgrep -f 'python iologger.py' on SIL 1-8:
date;ansible iologger1_8 -m shell -a "pgrep -f 'python iologger.py'"
# change ownership of iologger* to nciadmin on SIL 1-8:
date;for i in $(ansible iologger1_8 --list-hosts|grep bvn);do echo $i;ssh -tt $i "cd ~nciadmin;su -c 'chown -v nciadmin: iologger*'";done
# delete ~nciadmin/iologger* on SIL 1-8:
###date;ansible iologger1_8 -m file -a "dest=~nciadmin/iologger.zip state=absent"
###date;ansible iologger1_8 -m file -a "dest=~nciadmin/iologger state=absent"
###date;for i in $(ansible iologger1_8 --list-hosts|grep bvn);do echo $i;ssh -tt $i "su -c 'rm -frv ~nciadmin/iologger'";done
# copy the new iologger.zip to SIL 1-8 via ansible:
date;ansible iologger1_8 -m copy -a "src=iologger.zip dest=~nciadmin mode=644 group=nciadmin"
# change ownership of iologger.zip to nciadmin on SIL 1-8:
date;for i in $(ansible iologger1_8 --list-hosts|grep bvn);do echo $i;ssh -tt $i "cd ~nciadmin;su -c 'chown -v nciadmin: iologger.zip'";done
# unzip the iologger.zip on ~nciadmin for SIL 1-8:
date;for i in $(ansible iologger1_8 --list-hosts|grep bvn);do echo $i;ssh -tt $i "cd ~nciadmin;su nciadmin -c 'unzip -f iologger.zip'";done
# cleanup the iologger/logs folders on SIL 1-8:
date;for i in $(ansible iologger1_8 --list-hosts|grep bvn);do echo $i;ssh -tt $i "cd ~nciadmin/iologger/logs;su -c 'rm -fv iolog*'";done
# change owner back to nciadmin for the iologger folder on SIL 1-8:
###date;for i in $(ansible iologger1_8 --list-hosts|grep bvn);do echo $i;ssh -tt $i "su -c 'chown -R nciadmin: ~nciadmin/iologger'";done
# restart the python iologger script in the backgroud on SIL 1-8:
date;for i in $(ansible iologger1_8 --list-hosts|grep bvn);do echo $i;ssh -ttt $i "cd ~nciadmin/iologger;su -c 'nohup ~aaw/restart-iologger-py.sh >/dev/null 2>&1 &'";sleep 1;done
# check if process is running with pgrep -f 'bash /home/aaw/restart-iologger-py.sh' on SIL 1-8:
date;ansible iologger1_8 -m shell -a "pgrep -f 'bash /home/aaw/restart-iologger-py.sh'"
# check to see if the logs are being written on SIL 1-8 via ansible:
date;ansible iologger1_8 -m shell -a "cd ~nciadmin/iologger/logs;ls -ltr"
