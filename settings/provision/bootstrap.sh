#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
# Packages
CURL="curl"
NODE="nodejs"
MONGO="mongod"
GCC="gcc"
GPLUSPLUS="g++"
MAKE="make"
GIT="git"
GO="go"
PYTHON="python"
MYSQL="mysql"
BOWER="bower"
NPM="npm"
GULP="gulp"
MYSQL_PASS="admin123"


           
# update

sudo apt-get update
sudo apt-get -y upgrade

# Install required command software
sudo apt-get -y install software-properties-common
sudo apt-get update
sudo apt-get -y install expect zip unzip

# curl
if !  [ -x "$(command which $CURL)" ]; then

sudo apt-get -y install $CURL 
else
    echo "Curl already installed."
fi

# nodejs 
#if !  [ -x "$(command which $NODE)" ]; then

#sudo apt update
#sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
#curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
#sudo apt -y install $NODE
#sudo apt-get install nodejs-legacy
## Update package list, then install node and npm
#sudo apt-get update && sudo apt-get install nodejs npm

# Download nvm install.sh and run with bash
sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash

# reload .bashrc so nvm command works
sudo source ~/.bashrc

# Explicitly install supported node version
sudo nvm install 10.16

# Install Stencil CLI
sudo npm install -g @bigcommerce/stencil-cli

$NODE --version

#else
#    echo "nodejs already installed."
#fi


# MongoDB
if ! [ -x "$(command which $MONGO )" ]; then
   echo "mongob installation start ..................................................."
   sudo apt-get install gnupg
   wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
   echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
  sudo apt-get update
  sudo apt-get install -y mongodb-org
  echo "mongodb-org hold" | sudo dpkg --set-selections
  echo "mongodb-org-server hold" | sudo dpkg --set-selections
  echo "mongodb-org-shell hold" | sudo dpkg --set-selections
  echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
  echo "mongodb-org-tools hold" | sudo dpkg --set-selections
  sudo service mongod status

fi

# gcc 
if !  [ -x "$(command which $GCC)" ]; then

sudo apt-get -y install $GCC
else
    echo "$GCC already installed."
fi

# g++ 
if !  [ -x "$(command which $GPLUSPLUS)" ]; then
sudo apt-get -y install $GPLUSPLUS
else
    echo "$GPLUSPLUS already installed."
fi

# make 
if !  [ -x "$(command which $MAKE)" ]; then
sudo apt-get -y install gcc $MAKE
else
    echo "$MAKE already installed."
fi

# git 
if !  [ -x "$(command which $GIT)" ]; then
sudo apt-get -y install $GIT
else
    echo "Git already installed."
fi


#  Go lang  
if !  [ -x "$(command which $GO)" ]; then

sudo add-apt-repository ppa:duh/golang
sudo apt-get update
sudo apt-get -y install golang

else
    echo "Golang already installed."
fi 

# python 
if !  [ -x "$(command which $PYTHON)" ]; then
sudo apt-get -y install $PYTHON
else
    echo "Python already installed."
fi

# Maria DB 
if !  [ -x "$(command which $MYSQL)" ]; then
  sudo apt-get install -y mariadb-server mariadb-client
  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service
  sudo systemctl status mariadb
else
   echo "Mysql already installed."
fi


curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn
yarn --version

# Bower
sudo chown -R $USER:$GROUP ~/.config
#if !  [ -x "$(command which --version bower )" ]; then
   sudo npm install  $BOWER -g
#fi

# Gulp
sudo chown -R $USER:$GROUP ~/.config
#if !  [ -x "$(command which --version gulp)" ]; then
 sudo npm install -g $GULP
#fi


sudo chown -R $USER:$GROUP ~/.config

#***********************************Mysql secure instalation************************#
  
#MYSQL=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $11}')



expect -f - <<-EOF
  set timeout 10
  spawn mysql_secure_installation
  expect "Enter current password for root (enter for none):"
  send -- "\r"
  expect "Set root password?"
  send -- "y\r"
  expect "New password:"
  send -- "${MYSQL_PASS}\r"
  expect "Re-enter new password:"
  send -- "${MYSQL_PASS}\r"
  expect "Remove anonymous users?"
  send -- "y\r"
  expect "Disallow root login remotely?"
  send -- "y\r"
  expect "Remove test database and access to it?"
  send -- "y\r"
  expect "Reload privilege tables now?"
  send -- "y\r"
  expect eof
EOF
