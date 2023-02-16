from util.constants import DIR_OUT_DIRECTORY
from util.util import runCommand

def runAutoAnalyses(analysisResultsPath: str) -> None:
    runCommand(f"./src/analysis/runAutoAnalyses.sh {DIR_OUT_DIRECTORY} {analysisResultsPath}")
