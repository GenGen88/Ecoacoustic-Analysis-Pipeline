import os

from util.constants import DIR_BIRDNET_OUT_FILE_PATH
from util.util import runCommand

def runAutoAnalyses() -> None:
    runCommand("./src/analysis/runAutoAnalyses.sh")
