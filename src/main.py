from environmentVariables.environmentVariables import createEnvironmentVariablesCSV
from emu.emu import runEmu, stripMetadata
from util.util import throwError, initConsole, pathExists, directoryFiles, closeConsole, deleteFile, runCommand
from util.initDirectory import validateDirectoryStructure

from analysis.runAnalysisScripts import runAnalysis

from util.constants import ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE, ERROR_404_MESSAGE, CLA_FILE_IN_POSITION, EMU_SCRIPT_PATH

from time import sleep
import sys

if __name__ == "__main__":
    # ensure that the CLI is standardized
    initConsole()

    cliArguments = sys.argv

    # ensure that the working directory is standardized
    validateDirectoryStructure()

    if len(cliArguments) < CLA_FILE_IN_POSITION + 1:
        throwError(ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE)

    audioInFilePath = cliArguments[CLA_FILE_IN_POSITION]

    # in pipeline mode, when an audio file is processed, it is deleted. It will then continue looking for audio files
    # until the user terminates the program with Ctrl + C
    pipelineMode = False
    isVerbose = False

    for arg in cliArguments:
        if arg == "--pipeline":
            print("\tProgram is running in pipeline mode!\n\tTo terminate the program, please press Ctrl + C\n")
            pipelineMode = True

        if arg == "--verbose":
            isVerbose = True

    while (True):
        # check that the audio file or directory exists
        if not pathExists(audioInFilePath):
            throwError(ERROR_404_MESSAGE, errorCode=404)

        allFiles = directoryFiles(audioInFilePath)

        if pipelineMode:
            # before analyzing files, they need to be fully downloaded
            # so assert that the previous audio recording was successfully downloaded by asserting that
            # there is a new download that has started.
            # for standard run (not pipeline mode), we can assume that the files are fully downloaded and skip this assertion
            if len(allFiles) <= 2:
                continue
            else:
                fileToAnalyze = allFiles[0]

                if "--noemu" not in cliArguments:
                    runEmu(fileToAnalyze)

                newInFile = stripMetadata(fileToAnalyze)
                createEnvironmentVariablesCSV(newInFile)

                # I'm not sure if these sleep statements are needed
                # if not, they will be removed in a future iteration
                sleep(0.5)
                deleteFile(fileToAnalyze)
                sleep(0.5)
        else:
            # run emu on all the audio files to ensure that all known bugs are fixed
            if "--noemu" not in cliArguments:
                runEmu()

            for file in allFiles:
                allFiles = directoryFiles(audioInFilePath)

                if isVerbose:
                    print(f"Files to analyze: {allFiles}")

                newInFile = stripMetadata(file)
                createEnvironmentVariablesCSV(newInFile)

            # since this is a CLI application, close it in a standard way
            # this is not needed, but I find it to be best practice
            closeConsole()
