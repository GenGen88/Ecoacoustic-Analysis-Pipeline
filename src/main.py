from fetchEnvironmentalVariables.environmentVariables import createEnvironmentVariablesCSV
from util.util import throwError, initConsole, pathExists
from util.constants import INVALID_ARGUMENTS_ERROR_MESSAGE, ERROR_404

import sys

# should take the recording file name as the first argument
if __name__ == "__main__":

    initConsole()

    if len(sys.argv) < 2:
        throwError(INVALID_ARGUMENTS_ERROR_MESSAGE)

    audioInFilePath = sys.argv[1]

    # check that the audio file or directory exists
    if not pathExists(audioInFilePath):
        throwError(ERROR_404)

    createEnvironmentVariablesCSV(sys.argv[1])
