#!/bin/bash

set_tf() {
        printf "\n Installing Tensorflow\n"
        conda install -y tensorflow
        /opt/anaconda3/bin/pip install --upgrade tensorflow
        printf "\n Installed Tensorflow:\n"

}

set_tf
