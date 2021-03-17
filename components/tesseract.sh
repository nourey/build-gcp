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

set_tesseract 

