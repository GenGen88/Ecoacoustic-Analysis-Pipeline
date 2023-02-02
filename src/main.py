from environmentVariables.environmentVariables import createEnvironmentVariablesCSV
from util.util import throwError, initConsole, pathExists, directoryFiles, closeConsole, deleteFile
from util.initDirectory import validateDirectoryStructure

from analysis.runAnalysisScripts import runAnalysis

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
    if len(sys.argv) > CLA_PIPELINE_MODE_CLA_POSITION:
        if sys.argv[CLA_PIPELINE_MODE_CLA_POSITION] == "--pipeline":
            print("\tProgram is running in pipeline mode!\n\tTo terminate the program, please press Ctrl + C\n")
            pipelineMode = True

    # to ensure that this program still works without pipeline mode
    # it needs to run and quit once the pipeline has completed once by default
    # therefore, we can check if it is the first run. The pipeline should always complete once
    isFirstRun = True
    while (pipelineMode or isFirstRun):
        # check that the audio file or directory exists
        if not pathExists(audioInFilePath):
            throwError(ERROR_404_MESSAGE)

        allFiles = directoryFiles(audioInFilePath)

        # TODO: this should only print out if the --verbose flag is used
        print(f"Files to analyze: {allFiles}")

        # before analyzing files, they need to be fully downloaded
        # so assert that the previous audio recording was successfully downloaded by asserting that
        # there is a new download that has started.
        # for standard run (not pipeline mode), we can assume that the files are fully downloaded and skip this assertion
        if len(allFiles) <= 2 and not isFirstRun:
            continue

        for file in allFiles:
            createEnvironmentVariablesCSV(file)
            
            if pipelineMode:
                deleteFile(file)
        
        isFirstRun = False

    # the second part of this program is to analyze the relationship between environment variables
    # runAnalysis(DIR_TOTAL_REPORT_OUT_FILE_PATH)

    # since this is a CLI application, close it in a standard way
    # this is not needed, but I find it to be best practice
    closeConsole()
