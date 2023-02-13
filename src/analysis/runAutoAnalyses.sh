#!/bin/bash

for file in ./src/analysis/scripts/auto/*.r
do
  Rscript $file
done
