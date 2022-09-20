#!/bin/bash
function install-apps {
	sudo apt update && sudo apt upgrade -y
	sudo apt install curl build-essential git wget jq make gcc ack tmux ncdu unzip wget git dialog -y
	sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.27.3/yq_linux_amd64 && chmod +x /usr/local/bin/yq
	sudo apt update
}
###########################################################
function install-docker {
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}
###########################################################
function install-stack {
	install-apps
#############check  docker  installed or not#########
pkg='docker'
which $pkg > /dev/null 2>&1
## 2 is error ####
if [ $? == 0 ]
then
        echo "$pkg is already installed. "
else
        echo "$pkg not install"
        install-docker
fi
}
#######################################################
install-stack
cd $HOME
rm -rf subspace-docker-folder
mkdir subspace-docker-folder
cd subspace-docker-folder
PORTS = (4000 5000 6000)
