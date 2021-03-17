#!/bin/bash

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

set_docker
