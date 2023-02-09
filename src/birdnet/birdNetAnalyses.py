import os
from util.constants import DIR_BIRDNET_OUT_FILE_PATH
from util.util import runCommand

def runBirdNet(fileName: str) -> None:
    print(f"\nRunning analysis on {fileName}, printing results to {DIR_BIRDNET_OUT_FILE_PATH}")
    runCommand(f"./src/birdnet/runBirdnet.sh {fileName} {DIR_BIRDNET_OUT_FILE_PATH}")
