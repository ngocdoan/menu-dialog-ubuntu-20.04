#!/bin/bash
#########################
#Ask port ranges array
function ADDPORTARRAY {
PORTARRAY=()
echo "Please provide 3 port ranges for the nodes"
read -p -r 'Port range #1: Press ENTER if you want to use the default port' -e -i '4000' port1
PORTARRAY+=("$port1")
read -p -r 'Port range #2: Press ENTER if you want to use the default port' -e -i '5000' port2
PORTARRAY+=("$port2")
read -p -r 'Port range #3: Press ENTER if you want to use the default port' -e -i '6000' port3
PORTARRAY+=("$port3")
}
##########################
function start-install {
cd $HOME || exit
rm -rf subspace-docker-folder
mkdir subspace-docker-folder
cd subspace-docker-folder || exit
mkdir $NODEQUANTITY
cd $NODEQUANTITY || exit
wget -O docker-compose.yaml https://raw.githubusercontent.com/owlstake/testnet/main/subspace/docker-compose.yaml
sudo tee $HOME/$node-number/.env > /dev/null <<EOF
IMAGETAG=gemini-2a-2022-sep-10
NODENAME=owlstake$node-number
PORT1=PORTARRAY[0]
PORT2=PORTARRAY[1]
PORT3=PORTARRAY[2]
REWARDADDRESS=$(arrrewardaddress[$NODEQUANTITY])
PLOTSIZE=10G
EOF
############
docker compose up -d
sleep 10
}
##########################
CPUCORE=$(nproc)
readarray -t arrrewardaddress <rewardaddress.txt
arrlength=${#arrrewardaddress[@]}
NODEQUANTITY=0
if [[ $CPUCORE -eq $arrlength ]]
then
echo "Number of CPU core is $CPUCORE"
echo "Number of reward address is $arrlength"
echo "Result: equal --> Starting to install the node"
###############################
# Start install function here
start-install
###############################
NODEQUANTITY=$CPUCORE
echo "We will install $NODEQUANTITY nodes"
elif [[ $CPUCORE -lt $arrlength ]]
then
echo "Number of CPU core is $CPUCORE"
echo "Number of reward address is $arrlength"
echo "Result: CPU core < reward address --> Starting to install the node based on number of CPU core"
NODEQUANTITY=$CPUCORE
echo "We will install $NODEQUANTITY nodes"
###############################
# Start install function here
start-install
###############################
elif [[ $CPUCORE -gt $arrlength ]]
then
echo "Number of CPU core is $CPUCORE"
echo "Number of reward address is $arrlength"
echo "Result: CPU core > reward address"
##### Ask question before doing
while true; do
read -p -r "Do you want to continue install the nodes based on number of reward address? (yes/no) " yn
case $yn in 
	yes ) echo ok, we will proceed;
		break;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;;
esac
done
###############################
NODEQUANTITY=$arrlength
echo "We will install $NODEQUANTITY nodes"
###############################
# Start install function here
start-install
###############################
#####
fi

