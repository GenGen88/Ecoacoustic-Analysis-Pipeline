#!/bin/bash

# in the case that the setup.sh script has not been run, the program should initilize birdnet
if [ ! -d "./src/lib/BirdNET-Analyzer/" ]; then
    ./src/setup_lib.sh;
fi

# TODO: this should check if the user is using python or python3
python3 ./lib/BirdNET-Analyzer/analyze.py --i $1 --o $2;
