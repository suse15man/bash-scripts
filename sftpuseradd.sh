#!/usr/bin/env bash

echo "Begin of Main"
read -p "Enter customer's web url: " weburl
read -p "Enter customer's IP Address: " ipaddr
read -p "Enter customer's new password: " newpassword
echo "${weburl}:${newpassword}" > ${weburl}.$$

# checking the validity of the IP Addr:
ipcalc $ipaddr |awk 'BEGIN{FS=":"; is_invalid=0} /^INVALID/ {is_invalid=1; print $1} END{exit is_invalid}'
if [[ $? -ne 0 ]];then
	echo "$ipaddr is NOT valid:"
	ipcalc $ipaddr
	echo "Exiting."
	exit 1
fi

# Adding ($weburl $ipaddr) line to file /root/sftpusers.access:
echo "Check if $weburl already exists in /root/sftpusers.access:"
sudo grep -q $weburl ~root/sftpusers.access
if [[ $? -eq 0 ]];then
	echo "$weburl already exists in sftpusers.access file"
	echo "Exiting."
	exit 0
else
	echo "Adding $weburl and $ipaddr to file /root/sftpusers.access:"
	echo "$weburl $ipaddr"|sudo tee -a /root/sftpusers.access
	sudo ~root/whitelist_ips
fi

# check if sftp user exists, if not add user:
echo "check if sftp user already exists:"
grep -q $weburl /etc/passwd
if [[ $? -eq 0 ]];then
	echo "$weburl is already an sftp user"
	ls -ailh /sftp/${weburl}
	echo "Exiting."
	exit 0
else
	echo "Creating sftp user $weburl:"
	sudo ~root/sftpuseradd $weburl
	ls -ailh /sftp/${weburl}
fi

# changing the password for new sftp user:
###newpassword=$(openssl rand -hex 8)
echo "Changing password for user $weburl:"
sudo chpasswd < ${weburl}.$$
echo "End of Main"
