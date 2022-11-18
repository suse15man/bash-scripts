sudo yum update -y
sudo yum groupinstall -y "Development Tools"
sudo yum install -y autoconf automake19 libtool gettext \
			git scons cmake flex bison \
			libcurl-devel curl \
			ncurses-devel ruby bzip2-devel expat-devel
