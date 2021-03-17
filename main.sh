#!/bin/bash

dir="~/build-gcp"

cd $dir
sudo chmod -R 777 $dir

clear
bash configure-instance/executer.sh

clear
bash configure-instance/gcloud.sh

clear
read -p "Which name do you want to give your Google VM Instance? " INSTANCE_NAME

clear
source configure-instance/check-availability.sh
export INSTANCE_TYPE=$INSTANCE_TYPE
export ZONE=$ZONE

clear
source configure-instance/disk-size.sh
export BOOT_DISK_SIZE=$BOOT_DISK_SIZE

clear
printf "\n"
export IMAGE_PROJECT="debian-cloud"
export IMAGE="debian-10-buster-v20210217"
echo "Your Instance Configuration is as below:"
echo "          --[1] Instance Name: " $INSTANCE_NAME
echo "          --[2] Instance Type: " $INSTANCE_TYPE
echo "          --[3] Zone:          " $ZONE
echo "          --[4] Disk Size:     " $BOOT_DISK_SIZE
printf "\n"

bash ~/build-gcp/configure-instance/verify_configuration

source configure-instance/verify-configuration.sh
export INSTANCE_NAME=$INSTANCE_NAME
export INSTANCE_TYPE=$INSTANCE_TYPE
export ZONE=$ZONE
export BOOT_DISK_SIZE=$BOOT_DISK_SIZE

clear
bash configure-instance/build-instance.sh

clear
gcloud auth login
PROJECT=$(gcloud config get-value core/project 2> /dev/null)

clear
printf "\nWaiting for the machine to be raised."
sleep 10

printf "\nPreparing for second step\n"
sudo gcloud compute scp --recurse /home/build-gcp $INSTANCE_NAME:/home --ssh-key-expire-after=10m --project $PROJECT --zone $ZONE
printf "\nSecond step is sent"

sleep 1

printf "\nEstablishing SSH\n"
gcloud compute ssh $INSTANCE_NAME --project $PROJECT --zone $ZONE --command 'bash /home/build-gcp/conda/conda.sh'
echo "Setup is done. You can simply establish your SSH connection via:
gcloud compute ssh" $INSTANCE_NAME
