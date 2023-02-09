#!/bin/bash


# if emu is not installed, we want to fail gracefully
which emu;
if [ $? -eq 0 ]; then
    emu fix apply --all $1;
else
    echo "Warning: EMU is not installed";
    echo -e "\tAny bugs in audio files will not fixed and will be reported as corrupted"
    echo -e "\tPlease install emu from https://github.com/QutEcoacoustics/emu"
fi
