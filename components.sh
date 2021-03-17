#!/bin/bash

set_tesseract() {
        printf "\n Installing Tesseract-OCR\n"
        sudo apt-get install -y libtool
        sudo apt-get install -y libleptonica-dev
        sudo apt-get update -y
        sudo apt-get install automake
        sudo apt-get install -y pkg-config
        sudo apt-get install -y libsdl-pango-dev
        sudo apt-get install -y libicu-dev
        sudo apt-get install -y libcairo2-dev
        sudo apt-get install -y bc
        sudo apt-get update -y
        sudo apt-get install -y build-essential
        sudo apt-get install -y manpages-dev
        wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
        sudo apt-add-repository "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch main"
        sudo apt-get update -y
        sudo apt-get install -y clang clang-format clang-tidy lldb libc++-8-dev libc++abi-8-dev
        sudo apt-get install -y unzip
        sudo wget https://github.com/tesseract-ocr/tesseract/archive/4.1.1.zip
        sudo chmod -R 777 4.1.1.zip
        sudo unzip 4.1.1.zip
        cd tesseract-4.1.1
        sudo ./autogen.sh
        sudo ./configure
        sudo make
        sudo make install
        sudo ldconfig
        sudo make training
        sudo make training-install
}

set_jupyter() {
        printf "\nInstalling Jupyter Notebook\n"
        conda install -c conda-forge notebook -y
        printf "\nInstalled Jupyter Notebook\n"
}

set_tf() {
        printf "\n Installing Tensorflow\n"
        conda install -y tensorflow
        /opt/anaconda3/bin/pip install --upgrade tensorflow
        printf "\n Installed Tensorflow:\n"

}

set_pytorch() {
        printf "\nInstalling Pytorch\n"
        conda install pytorch torchvision torchaudio cpuonly -c pytorch -y
        conda update pytorch torchvision -y
        printf "\nInstalled Pytorch\n"
}

set_docker() {
        printf "\nInstalling Docker\n"
        sudo apt-get remove -y docker docker-engine docker.io containerd runc
        sudo apt-get update -y
        sudo apt-get install -y \
                apt-transport-https \
                ca-certificates \
                curl \
                gnupg-agent \
                software-properties-common
        sudo apt-get update -y
        sudo curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker $USER
        sudo docker run hello-world
}

cd /home

printf "These are the components that will be installed:\n"
sudo chmod -R 777 /home/build-gcp/components-list.txt
less -FX /home/build-gcp/components-list.txt
sleep 7

sudo apt-get install -y wget
sudo add-apt-repository -y universe
sudo apt-get install -y python-setuptools

source /opt/anaconda3/etc/profile.d/conda.sh
conda install -c anaconda pip -y
/opt/anaconda3/bin/pip install --upgrade pip

set_tesseract
set_jupyter
set_tf
set_pytorch
set_docker

exit
