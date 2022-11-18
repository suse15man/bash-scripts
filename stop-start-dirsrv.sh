#!/usr/bin/env bash

# As vksadmin, Run vks monitor to verify the TAS node which is running the Directory Server.
vks monitor|grep Directory
# As vksadmin, on the TAS Node identified in Step 1. above Stop the Directory Server (dirsrv) service.
vks stop dirsrv
sleep 10m
vks start dirsrv
# Watch the progress of the build of the LDAP DB:
cd /var/log
tail -f ldap.log
