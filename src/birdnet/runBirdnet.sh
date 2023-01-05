#!/bin/bash

if [ ! -d "./src/lib/BirdNET-Analyzer/" ]; then
    ./src/lib/clone-birdnet.sh;
fi

python3 ./src/lib/BirdNET-Analyzer/analyze.py --i $1 --o $2;
