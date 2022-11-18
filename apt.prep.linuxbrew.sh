sudo apt-get install -y build-essential make cmake scons curl git \
				ruby autoconf automake autoconf-archive \
				gettext libtool flex bison \
				libbz2-dev libcurl4-openssl-dev \
				libexpat-dev libncurses-dev
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/aaw/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
