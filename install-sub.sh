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

#####################
khai bao mảng port = (4000 5000 6000)


tìm ra số core CPU --ví dụ == 8 --> core = 8
for 
cho n = 0
tăng mảng dần cho đến khi n = core
n=1 -->
port = 4001 5001 6001
cd $HOME
mkdir n=1
cd n=1
down docker file
down .env file
dung lenh sed replace hoac tee

# create service
sudo tee $HOME/$n/.env > /dev/null <<EOF
IMAGETAG=gemini-2a-2022-sep-10
NODENAME=owlstake$n
PORT1=port[0]
PORT2=port[1]
PORT3=port[2]
REWARDADDRESS=st8AwHwQV8479Gdfo42GvxWgcRCz6Q7qcW3rHkV9tT6daKBAw
PLOTSIZE=10G
EOF
docker compose up -d
sleep 10

#######################
PORT=(4000 5000 6000)
N=0
CPU=5

for (( N=1; N<=$CPU; N++ ))
do  
  echo "$N"
  printf '%s\n' "${PORT[@]}"
  PORT[0]=$((PORT[0]+1))
  PORT[1]=$((PORT[1]+1))
  PORT[2]=$((PORT[2]+1))
done
##########################################
# read file and add each line to an array:
readarray -t arr <rewardaddress.txt

# print each line
for value in "${arr[@]}"
do
echo $value
done
#
###########################################
# append to array 
mang=()
mang+=("doan")
mang+=("hang")

for value in "${mang[@]}"
do
echo $value
done
################################
# count leangth of array
a=(1 2 3 4)
echo ${#a[@]}
# 4
######################################
