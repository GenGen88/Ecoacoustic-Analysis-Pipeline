from util.constants import DIR_IN_DIRECTORY, PRE_PROCESSING_SCRIPT_PATH, DIR_PROCESSING_DIRECTORY
from util.util import pathExists, runCommand, deletePath, createFolder
from time import sleep

def runAutomatedPreProcessing(path: str = DIR_IN_DIRECTORY) -> None:
    runCommand(f"{PRE_PROCESSING_SCRIPT_PATH} {path}")

# TODO: Find out why this step is sometimes necessary
def stripMetadata(path: str) -> str:
    inFileName = path.split("/").pop()
    processedFile = DIR_PROCESSING_DIRECTORY + inFileName

    if pathExists(DIR_PROCESSING_DIRECTORY):
        deletePath(DIR_PROCESSING_DIRECTORY)

    createFolder(DIR_PROCESSING_DIRECTORY)

    sleep(0.1)
    # use ffmpeg to string the metadata
    runCommand(f"ffmpeg -i {path} -map_metadata -1 -c:v copy -c:a copy {processedFile}")

    return processedFile
