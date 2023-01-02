#!/bin/bash

git clone https://github.com/kahst/BirdNET-Analyzer.git;

sudo zypper install -y docker;

sudo pip3 install tensorflow;
sudo pip3 install librosa;
sudo pip3 install numpy;

mkdir out/;
