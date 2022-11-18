#!/usr/bin/env bash

for i in $(awk '/bvn.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh -tt $i "su -c 'setfacl -m u:aaw:rw ~nciadmin'";done
for i in $(awk '/sil.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh -tt $i "su -c 'setfacl -m u:aaw:rw ~nciadmin'";done
for i in $(awk '/itt.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh -tt $i "su -c 'setfacl -m u:aaw:rw ~nciadmin'";done

# to view the ACL
for i in $(awk '/itt.*(no|cp)/{print $2}' /etc/hosts);do echo $i;ssh -tt $i "getfacl ~nciadmin";done
