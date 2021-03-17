#!/bin/bash

cd /home

printf "These are the components that will be installed:\n"
sudo chmod -R 777 /home/build-gcp/information-files/components-list.txt
less -FX /home/build-gcp/information-files/components-list.txt
sleep 7

sudo apt-get install -y wget
sudo add-apt-repository -y universe
sudo apt-get install -y python-setuptools

source /opt/anaconda3/etc/profile.d/conda.sh
conda install -c anaconda pip -y
/opt/anaconda3/bin/pip install --upgrade pip

bash build-gcp/components/tesseract.sh
bash build-gcp/components/tensorflow.sh
bash build-gcp/components/pytorch.sh
bash build-gcp/components/notebook.sh
bash build-gcp/components/docker.sh

exit
