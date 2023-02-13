#!/bin/bash

find . -name "__pycache__" | xargs rm -rf;
find . -name "venv" | xargs rm -rf;
rm -rf ./src/lib/;
rm ./.RData;
rm ./.Rhistory;
