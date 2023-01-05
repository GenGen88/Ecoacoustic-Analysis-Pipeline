from fetchEnvironmentalVariables.environmentVariables import createEnvironmentVariablesCSV
from util.util import throwError, initConsole, pathExists
from initDirectory import validateDirectoryStructure

from util.constants import ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE, ERROR_404_MESSAGE, CLA_FILE_IN_POSITION

import sys

if __name__ == "__main__":
    # ensure that the CLI is standardized
    initConsole()

    # ensure that the working directory is standardized
    validateDirectoryStructure()

    if len(sys.argv) < CLA_FILE_IN_POSITION + 1:
        throwError(ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE)

    audioInFilePath = sys.argv[CLA_FILE_IN_POSITION]

    # check that the audio file or directory exists
    if not pathExists(audioInFilePath):
        throwError(ERROR_404_MESSAGE)

    createEnvironmentVariablesCSV(sys.argv[1])
