#!/bin/bash

set_conda() {
        clear
        printf "\nDo not forget to specify Anaconda Path to /opt/anaconda3\n"
        echo ''
        echo ''
        sleep 5
        cd /tmp
        sudo apt-get install -y \
        libgl1-mesa-glx \
        libegl1-mesa \
        libxrandr2 \
        libxrandr2 \
        libxss1 \
        libxcursor1 \
        libxcomposite1 \
        libasound2 \
        libxi6 \
        libxtst6
        curl -O https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
        sudo chmod -R 777 /opt
        bash Anaconda3-2020.11-Linux-x86_64.sh
        sudo chmod -R 755 /opt
        source ~/.bashrc

}

upd_conda() {
        conda update --all -y
}

cd /home

clear
echo "Installing Anaconda 3"
sleep 7

sudo apt-get install -y wget
sudo add-apt-repository -y universe
sudo apt-get install -y python-setuptools

set_conda

source /opt/anaconda3/etc/profile.d/conda.sh
conda install -c anaconda pip -y

echo "Updating all conda packages "
upd_conda

bash /home/build-gcp/components.sh

