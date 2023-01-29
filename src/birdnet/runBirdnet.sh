#!/bin/bash

# this line is needed for the case where the audio files are corrupted
# in this case, birdnet results will not be produced. So if we don't delete previous results, the pipeline will use the last "good" results
# therefore, causing duplicate results, and bad data
if [ -f "./out/birdnet-results.csv" ]; then
    rm $2;
fi

# in the case that the setup.sh script has not been run, the program should initilize birdnet
if [ ! -d "./src/lib/BirdNET-Analyzer/" ]; then
    ./src/setup_lib.sh;
fi

# TODO: this should check if the user is using python or python3
python3 ./lib/BirdNET-Analyzer/analyze.py --i $1 --o $2;
