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
        sudo apt-get install bc
	sudo apt-get update
	sudo apt-get install build-essential
	sudo apt-get install manpages-dev
	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
	sudo apt-add-repository "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch main"
	sudo apt-get update
	sudo apt-get install -y clang clang-format clang-tidy lldb libc++-8-dev libc++abi-8-dev
	sudo apt-get install unzip
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
	printf "\nInstalled version of tesseract-ocr:\n $(tesseract --version)" 
}

set_jupyter() {
	printf "\nInstalling Jupyter Notebook\n"
        pip3 install notebook
        printf "\nInstalled Jupyter Notebook\n"
}

set_tf() {
	printf "\n Installing Tensorflow\n"
	pip3 install --upgrade tensorflow==2.0.0-rc0
	pip3 install --upgrade tensorflow
	printf "\n Installed Tensorflow:\n"
	python3 -c 'import tensorflow as tf;print(tf.__version__)'

}

set_pytorch() {
	printf "\nInstalling Pytorch\n"
	pip3 install torch==1.7.1+cpu torchvision==0.8.2+cpu torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
	printf "\nInstalled Pytorch\n"
	python3 -c 'import torch;print(torch.__version__)'
}

set_docker() {
	printf "\nInstalling Docker\n"
	sudo apt-get remove docker docker-engine docker.io containerd runc
        sudo apt-get update
	sudo apt-get install \
		apt-transport-https \
                ca-certificates \
                curl \
                gnupg-agent \
                software-properties-common
	sudo apt-get update
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

sudo apt-get install wget
sudo apt install python3-pip
python3 -m pip install --upgrade pip
sudo apt-get install python3-setuptools

set_tesseract
set_jupyter
set_tf
set_pytorch
set_docker

printf "\nAll the components have been installed. In order to get changes you have to reboot your terminal session.\n"
printf "\nAfter you rebooted your session you can simply establish your SSH connection with the command: gcloud compute ssh <instance name>\n"
