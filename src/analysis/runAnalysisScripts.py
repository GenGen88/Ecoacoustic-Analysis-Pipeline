import os

from util.constants import DIR_BIRDNET_OUT_FILE_PATH

def runAnalysis(fileName: str) -> None:
    os.system(f"./src/analysis/biodiversity.sh {fileName} {DIR_BIRDNET_OUT_FILE_PATH}")
