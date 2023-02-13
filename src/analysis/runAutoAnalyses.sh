#!/bin/bash

for file in ./src/analysis/scripts/auto/*
do
  Rscript $file
done
