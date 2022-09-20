#!/bin/bash
sudo apt install dialog -y

function install-apps {
	sudo apt update && sudo apt upgrade -y
	sudo apt install curl build-essential git wget jq make gcc ack tmux ncdu unzip wget git dialog -y
	sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.27.3/yq_linux_amd64 && chmod +x /usr/local/bin/yq
	sudo apt update
}

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
######### Dialog menu ##########################################
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Owlstake"
TITLE="Susbspace installer helper"
MENU="Choose one of the following options:"

OPTIONS=(1 "Installer docker and dependencies"
         2 "Option 2"
         3 "Option 3")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
################## Enter command for each choice ###########
case $CHOICE in
        1)
            echo "You chose Option 1"
			install-stack
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;
esac
##############################################################
