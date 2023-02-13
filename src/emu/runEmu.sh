#!/bin/bash


# if emu is not installed, we want to fail gracefully
which emu;
if [ $? -eq 0 ]; then
    emu fix apply -f FL001 -f FL005 -f FL008 -f FL010 -f FL011 -f FL012 $1;
else
    echo "Warning: EMU is not installed";
    echo -e "\tAny bugs in audio files will not fixed and will be reported as corrupted"
    echo -e "\tPlease install emu from https://github.com/QutEcoacoustics/emu"
fi
