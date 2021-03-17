#!/bin/bash

set_jupyter() {
        printf "\nInstalling Jupyter Notebook\n"
        conda install -c conda-forge notebook -y
        printf "\nInstalled Jupyter Notebook\n"
}

set_jupyter
