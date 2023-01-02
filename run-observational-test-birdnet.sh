#!/bin/bash

# clean working directory
rm -r ./out/;
mkdir ./out/;

python3 ./BirdNET-Analyzer/analyze.py --i ./tests/ --o ./out/;
