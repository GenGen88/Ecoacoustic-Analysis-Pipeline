from util.constants import DIR_IN_DIRECTORY, EMU_SCRIPT_PATH, DIR_PROCESSING_DIRECTORY
from util.util import pathExists, runCommand, deletePath, createFolder
from time import sleep

def runEmu(path: str = DIR_IN_DIRECTORY) -> None:
    runCommand(f"{EMU_SCRIPT_PATH} {path}")

# there was a bug in an old version of EMU that didn't calculate hashes correctly
# for this reason, if the audio files were run through an analyzer without removing metadata hashes
# the file would be incorrectly reported as corrupted
# for this reason, the hacky work around is to remove all metadata from the audio recordings
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
