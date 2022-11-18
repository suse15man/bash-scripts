#!/usr/bin/env bash

# login to salt-master => aaw@nyc-salt-master011
# change to root

salt-key -L|grep nm19
ll /srv/salt/ /var/lib/salt/|grep lrwxrwxrwx
salt "nm19*" saltutil.clear_cache;salt "nm19*" saltutil.sync_all
salt-key -L | grep nm19
salt 'nm19*' test.version
salt 'nm19*' vkscli.monitor|grep OutSvc
salt-run nm.software_releases -- nm19
salt-run nm.software_remove -- 5.1.0.0.f_18 nm19
salt-run nm.events_show -- nm19
salt-run nm.events_clear -- nm19
salt-run nm.software_clean -- nm19
salt-run nm.monitor -- nm19|grep DRBD
cd /srv/salt/nmol_media
salt-run nm.upgrade -- 5.1.0.0.g_21 nm19
# wait for Waiting for node activation to complete: nm-n0_upgrade/5.1.0.0.g_21
# goto nm19-node0
tail -f /opt/cv/logs/upgrade_5.1.0.0.g_21.log
# wait for  (activate) Release repository removed.
# Then Ctrl-C and touch the following file
touch /data/opt/cv/releases/5.1.0.0.g_21/.node_activated
# goto salt-master
salt-run nm.software_show -- nm19
salt-run nm.monitor -- nm19|grep Version
# log4j
salt-run mop2022_400.remove_log4j_files nm19
