import os

from util.constants import DIR_BIRDNET_OUT_FILE_PATH
from util.util import runCommand

def runAnalysis(fileName: str) -> None:
    runCommand(f"./src/analysis/biodiversity.sh {fileName} {DIR_BIRDNET_OUT_FILE_PATH}")
