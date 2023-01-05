#!/bin/bash

cd ./src/;

git clone https://github.com/kahst/BirdNET-Analyzer.git;

cd ..;

# for openSUSE
sudo zypper install -y docker;

# # for Raspberry Pi & other Debian based distributions
# sudo apt install -y docker.io;

sudo pip3 install tensorflow;
sudo pip3 install librosa;
sudo pip3 install numpy;

mkdir out/;
