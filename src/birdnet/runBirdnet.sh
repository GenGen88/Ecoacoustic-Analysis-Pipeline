#!/bin/bash

rm ./out/birdnet-results.csv;

if [ ! -d "./src/lib/BirdNET-Analyzer/" ]; then
    ./src/setup_lib.sh;
fi

python3 ./lib/BirdNET-Analyzer/analyze.py --i $1 --o $2;
