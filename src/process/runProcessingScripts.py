from util.constants import DIR_OUT_DIRECTORY
from util.util import runCommand

def runAutoProcessing(analysisResultsPath: str) -> None:
    runCommand(f"./src/process/runAutoProcessingScripts.sh {DIR_OUT_DIRECTORY} {analysisResultsPath}")
