#!/bin/bash

set_pytorch() {
        printf "\nInstalling Pytorch\n"
        conda install pytorch torchvision torchaudio cpuonly -c pytorch -y
        conda update pytorch torchvision -y
        printf "\nInstalled Pytorch\n"
}

set_pytorch
