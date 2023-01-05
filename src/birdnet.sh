#!/bin/bash

# for use in windows

git clone https://github.com/kahst/BirdNET-Analyzer.git;

python -m venv ./venv/;
source ./venv/Scripts/activate;
source ./venv/bin/activate;

pip install -r ./requirements.txt;
