#!/bin/bash

if [ ! -d "./lib/" ]; then
    mkdir ./lib/;
fi

if [ ! -d "./lib/BirdNET-Analyzer" ]; then
    cd ./lib/;
    git clone https://github.com/kahst/BirdNET-Analyzer.git;
fi
