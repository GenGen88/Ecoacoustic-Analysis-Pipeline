from environmentVariables.environmentVariables import createEnvironmentVariablesCSV
from util.util import throwError, initConsole, pathExists, directoryFiles, closeConsole, deleteFile
from util.initDirectory import validateDirectoryStructure

from util.constants import ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE, ERROR_404_MESSAGE, CLA_FILE_IN_POSITION, CLA_PIPELINE_MODE_CLA_POSITION

import sys

if __name__ == "__main__":
    # ensure that the CLI is standardized
    initConsole()

    # ensure that the working directory is standardized
    validateDirectoryStructure()

    if len(sys.argv) < CLA_FILE_IN_POSITION + 1:
        throwError(ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE)

    audioInFilePath = sys.argv[CLA_FILE_IN_POSITION]

    # in pipeline mode, when an audio file is processed, it is deleted. It will then continue looking for audio files
    # until the user terminates the program with Ctrl + C
    pipelineMode = False
    if len(sys.argv) >= CLA_PIPELINE_MODE_CLA_POSITION:
        if sys.argv[CLA_PIPELINE_MODE_CLA_POSITION] == "--pipeline":
            print("\tProgram is running in pipeline mode!\n\tTo terminate the program, please press Ctrl + C\n")
            pipelineMode = True

    while (pipelineMode):
        # check that the audio file or directory exists
        if not pathExists(audioInFilePath):
            throwError(ERROR_404_MESSAGE)

        allFiles = directoryFiles(audioInFilePath)

        print(f"Files to analyze: {allFiles}")

        for file in allFiles:
            createEnvironmentVariablesCSV(file)
            deleteFile(file)

    closeConsole()
