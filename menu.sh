#!/bin/bash
##################check  dialog  installed or not#########
pkg='dialog'
which $pkg > /dev/null 2>&1
## 2 is error ####
if [ $? == 0 ]
then
        echo "$pkg is already installed. "
else
        echo "$pkg not install"
        sudo apt install $pkg -y
fi
################### end ########################################
######### Dialog menu ##########################################
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="Choose one of the following options:"

OPTIONS=(1 "Option 1"
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
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;
esac
##############################################################
