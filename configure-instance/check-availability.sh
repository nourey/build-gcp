#!/bin/bash

check_availability() {
printf "\nSelect your machine type and your zone.\n"
printf "\nAs an example for selecting machine type, N2 standard machine type has 4gb memory for per CPU. Which means if you choose n2-standard-8 as your machine type, your machine will have 32 GB Memory.\nUsually n2-standard-8 has enough capabilities. But if you don't feel satisfied with the machine type you chosed, you can change your machine type anytime you want.\n"
printf "\nMore information for machine types visit: https://cloud.google.com/compute/docs/machine-types \n"
printf "\nSee how can you change your Instance type in GCP Dashboard: https://cloud.google.com/compute/docs/instances/changing-machine-type-of-stopped-instance#console\n"
printf "\nBe careful with your selected Zone. You may want to double check the correspondence Zone for your desired Instance Type.\n "

while :
do
read -p "
[1] To see available machine types in desired Zone.
[2] To see available zones for desired machine Type.
[3] When you find the right machine type with corresponding zone you can make your selection.

Please enter your numeric choice: " answ_zone
        case $answ_zone in
                [1]* )read -p "Select your Instance Zone to see available Instance Types: " ZONE;
                        gcloud compute machine-types list --filter $ZONE;;

                [2]* )read -p "Select your Machine Type to see available Zones: " INSTANCE_TYPE;
                        gcloud compute machine-types list --filter $INSTANCE_TYPE;;

                [3]* )read -p "Please enter your Instance Type and Instance Zone in the right format. (For an example europe-west3-c n2-standard-8): " ZONE INSTANCE_TYPE;
                        ZONE=$ZONE;
                        INSTANCE_TYPE=$INSTANCE_TYPE;
                        break;;
        esac
done
}

check_availability
