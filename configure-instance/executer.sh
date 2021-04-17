#!/bin/bash

executer() {
while :
do
        cat ~/build-gcp/information-files/WELCOME.txt
        printf "\n"
        read -p "+---------------------------------------+
|  To start y.          To exit n.      |
+---------------------------------------+
Y/N ? "  start_answer
        case $start_answer in
                [Yy]* )break;;
                [Nn]*)exit;;
        esac
done
}

executer
