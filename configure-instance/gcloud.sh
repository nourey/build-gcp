#!/bin/bash

set_gcloud() {
clear

cd /home

printf "\nDownloading google-cloud-sdk\n"

sudo curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-327.0.0-linux-x86_64.tar.gz
sudo chmod -R 777 google-cloud-sdk-327.0.0-linux-x86_64.tar.gz
sudo tar zxvf google-cloud-sdk-327.0.0-linux-x86_64.tar.gz
sudo chmod -R 777 google-cloud-sdk

cd google-cloud-sdk
clear

./install.sh
./bin/gcloud init

cd /home

}

set_gcloud
