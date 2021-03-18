#!/bin/bash

set_func_view() {
        printf "\nCurrent Instance Configuration: \n"
        echo "          --[1] Instance Name: " $INSTANCE_NAME
        echo "          --[2] Instance Type: " $INSTANCE_TYPE
        echo "          --[3] Zone:          " $ZONE
        echo "          --[4] Disk Size:     " $BOOT_DISK_SIZE
}

set_func() {
    while :
    do
        set_func_view
        printf "\n0 to save changes and exit.\n "
        read -p "Please enter your numeric choice:
        " func_answ
        case $func_answ in
                [1]* )read -p "New Instance Name: " new_name;
                        INSTANCE_NAME=$new_name;;
                [2]* )read -p "New Instance Type: " new_type;
                        INSTANCE_TYPE=$new_type;;
                [3]* )read -p "New Zone: " new_zone;
                        ZONE=$new_zone;;
                [4]* )read -p "New Disk Size: " new_size;
                        BOOT_DISK_SIZE=$new_size;
                        BOOT_DISK_SIZE+="GB";;
                [0]* ) break;;
        esac
    done
}

verify_configuration() {

read -p "Dou you want to make changes on your current configuration?
y/n ? " if_ans

if [ $if_ans == "y" ]
then
        set_func
elif [ $if_ans == "n" ]
then
        :
fi
}

verify_confifuration
