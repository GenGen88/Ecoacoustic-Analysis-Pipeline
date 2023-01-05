#!/bin/bash

git clone https://github.com/kahst/BirdNET-Analyzer.git;

python -m venv ./venv/;
source ./venv/bin/activate;

pip install -r ./requirements.txt;
