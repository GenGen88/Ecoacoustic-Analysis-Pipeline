import os

def runAnalysis() -> None:
    os.system(f"./src/analysis/biodiversity.sh {fileName} {DIR_BIRDNET_OUT_FILE_PATH}")
