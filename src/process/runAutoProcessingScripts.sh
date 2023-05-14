#!/bin/bash

for file in ./src/analysis/scripts/*.sh
do
    # scripts should follow the metadata standard defined in
    # https://github.com/ecoacoustics/metadata-standard/blob/master/cli.md
    # however, if the rscript is not expecting any CLA's, they should be ignored and not cause any breakage

    # the STD-IO pipes are used to run the R-Script as a Daemon, allowing for native BASH parelell processing
    $file --output $1 $2 >/dev/null 2>&1 < /dev/null &;
done
