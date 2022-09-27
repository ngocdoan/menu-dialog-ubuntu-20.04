#########################
#Ask port ranges array
PORTARRAY=()
echo "Please provide 3 port ranges for the nodes"
read -p 'Port range #1: ' -e -i '4000' port1
PORTARRAY+=($port1)
read -p 'Port range #2: ' -e -i '5000' port2
PORTARRAY+=($port2)
read -p 'Port range #3: ' -e -i '6000' port3
PORTARRAY+=($port3)
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
###############################
elif [[ $CPUCORE -gt $arrlength ]]
then
echo "Number of CPU core is $CPUCORE"
echo "Number of reward address is $arrlength"
echo "Result: CPU core > reward address"
##### Ask question before doing
while true; do
read -p "Do you want to continue install the nodes based on number of reward address? (yes/no) " yn
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

###############################
#####
fi

