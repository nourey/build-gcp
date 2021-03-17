#!bin/bash

export INSTANCE_NAME=$INSTANCE_NAME
export ZONE=$ZONE
export INSTANCE_TYPE=$INSTANCE_TYPE
export IMAGE=$IMAGE
export IMAGE_PROJECT=$IMAGE_PROJECT
export BOOT_DISK_SIZE=$BOOT_DISK_SIZE

build-instance() {
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
}

build-instance
