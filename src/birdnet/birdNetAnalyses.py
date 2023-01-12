import os
import time
from util.constants import DIR_BIRDNET_OUT_FILE_PATH

def runBirdNet(fileName: str) -> None:
    os.system(f"./src/birdnet/runBirdnet.sh {fileName} {DIR_BIRDNET_OUT_FILE_PATH}")
