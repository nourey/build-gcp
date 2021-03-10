#!/bin/bash

while :
do
        cat WELCOME.txt
        printf "\n"
        read -p "+---------------------------------------+
|  To start y.          To exit n.      |
+---------------------------------------+"  start_answer
        case $start_answer in
                [Yy]* )break;;
                [Nn]*)exit;;
        esac
done

cd /home

printf "\nDownloading google-cloud-sdk\n"

sudo curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-327.0.0-linux-x86_64.tar.gz
sudo chmod -R 777 google-cloud-sdk-327.0.0-linux-x86_64.tar.gz
sudo tar zxvf google-cloud-sdk-327.0.0-linux-x86_64.tar.gz
sudo chmod -R 777 google-cloud-sdk

cd google-cloud-sdk

printf "\nInstalling google-cloud-sdk\n"

./install.sh
./bin/gcloud init

cd /home

printf "\n"
read -p "Which name do you want to give your Google VM Instance? " INSTANCE_NAME

printf "\nSelect your machine type and your zone.\n" 
printf "\nAs an example for selecting machine type, N2 standard machine type has 4gb memory for per CPU. Which means if you choose n2-standard-8 as your machine type, your machine will have 32 GB Memory.\nUsually n2-standard-8 has enough capabilities. But if you don't feel satisfied with the machine type you chosed, you can change your machine type anytime you want.\n" 
printf "\nMore information for machine types visit: https://cloud.google.com/compute/docs/machine-types \n"
printf "\nSee how can you change your Instance type in GCP Dashboard: https://cloud.google.com/compute/docs/instances/changing-machine-type-of-stopped-instance#console\n" 
printf "\nBe careful with your selected Zone. You may want to double check the correspondence Zone for your desired Instance Type.\n "

while :
do
read -p "You can see available machine types in desired Zone by pressing z. 
You can see available zones for desired Machine Type by pressing m. 
When you find the right machine type with corresponding zone you can make your selection by pressing e. " answ_zone 
        case $answ_zone in
                [Zz]* )read -p "Select your Instance Zone to see available Instance Types: " ZONE;
                        gcloud compute machine-types list --filter $ZONE;;

                [Mm]* )read -p "Select your Machine Type to see available Zones: " INSTANCE_TYPE;
			gcloud compute machine-types list --filter $INSTANCE_TYPE;;

		[Ee]* )read -p "Please enter your Instance Type and Instance Zone in the right format. (For an example europe-west3-c n2-standard-8): " ZONE INSTANCE_TYPE;
			ZONE=$ZONE;
			INSTANCE_TYPE=$INSTANCE_TYPE;
                        break;;
        esac
done

printf "\n"
echo "Selected Zone: "$ZONE
echo "Selected Instance Type: "$INSTANCE_TYPE
printf "\n"

read -p "Give the integer value of Boot Disk Size in gb's (i.e. 120)" BOOT_DISK_SIZE
BOOT_DISK_SIZE+="GB"

read -p "This is the last step before initializing your machine. If you feel hesitant with your choices, you can change them now. (press enter) " answer
while :
do
	echo "To exit (Nn)" 
        echo "Which configuration do you want to edit?"
        echo "[1] Instance Name:" $INSTANCE_NAME
        echo "[2] Instance Type:" $INSTANCE_TYPE
        echo "[3] Zone:"    	  $ZONE
        echo "[4] Boot Disk Size:"$BOOT_DISK_SIZE

        read -p "You can select with numerical choices. " answer
        case $answer in
                [1]*  )read -p "Give your Instance a name " new_name;
                        INSTANCE_NAME=$new_name;;
                [2]*  )read -p "Select your new Instance Type " new_type;
                        INSTANCE_TYPE=$new_type;;
                [3]*  )read -p "Select your new Zone " new_zone;
                        ZONE=$new_zone;;
                [4]*  )read -p "Select new Boot Disk Size " new_bsize;
                        BOOT_DISK_SIZE=$new_bsize;
			BOOT_DISK_SIZE+="GB";;

		[Nn]* ) break;;

        esac
done

printf "\n"
export IMAGE_PROJECT="debian-cloud"
export IMAGE="debian-10-buster-v20210217"
echo "Your Instance Configuration is as below:"
echo "		--Instance Name: " $INSTANCE_NAME
echo "		--Instance Type: " $INSTANCE_TYPE
echo "		--Zone:          " $ZONE
echo "		--Boot Disk Size:" $BOOT_DISK_SIZE
echo "		--Image:  	 " $IMAGE
printf "\n"

gcloud compute instances create $INSTANCE_NAME \
        --zone=$ZONE \
        --machine-type=$INSTANCE_TYPE \
	--metadata serial-port-enable=TRUE \
	--image=$IMAGE \
	--image-project=$IMAGE_PROJECT \
	--boot-disk-size=$BOOT_DISK_SIZE

printf "\nYour machine has been configured. Now you have to login your gmail account to build the machine.\n"
gcloud compute firewall-rules create sample-http \
	--description "Incoming http and https allowed." \
 	--allow tcp:80,tcp:443,tcp:8888
printf "\nFirewall rules configured.\n"

gcloud auth login
PROJECT=$(gcloud config get-value core/project 2> /dev/null)

printf "\nWaiting for the machine to be raised."
sleep 10

printf "\nSending second step\n"
sudo gcloud compute scp --recurse /home/build-gcp $INSTANCE_NAME:/home --ssh-key-expire-after=2m --project $PROJECT --zone $ZONE
printf "\nSecond step is sent"

sleep 10

printf "\nEstablishing SSH\n"
gcloud compute ssh $INSTANCE_NAME --project $PROJECT --zone $ZONE --command 'cd /home/build-gcp && bash su-2.sh'
