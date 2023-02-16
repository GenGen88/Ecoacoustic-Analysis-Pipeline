#!/bin/bash

for file in ./src/analysis/scripts/auto/*.r
do
    # R scripts should follow the metadata standard defined in
    # https://github.com/ecoacoustics/metadata-standard/blob/master/cli.md
    # however, if the rscript is not expecting any CLA's, they should be ignored and not cause any breakage
    Rscript $file --output $1 $2
done
