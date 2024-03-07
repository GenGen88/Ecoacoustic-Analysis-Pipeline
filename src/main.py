from environmentVariables.environmentVariables import createEnvironmentVariablesCSV
from preProcessing.preProcessing import runAutomatedPreProcessing, stripMetadata
from util.util import throwError, initConsole, pathExists, directoryFiles, closeConsole, deleteFile, runCommand
from util.initDirectory import validateDirectoryStructure

from util.constants import ALLOW_DUPLICATES_CLA_ARGUMENT, DESTRUCTIVE_CLA_ARGUMENT, ERROR_ALL_CLA_ARGUMENT, ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE, ERROR_404_MESSAGE, CLA_FILE_IN_POSITION, FORCE_CLA_ARGUMENT, PIPELINE_CLA_ARGUMENT, RETAIN_METADATA_CLA_ARGUMENT, RETAIN_ORIGINAL_CLA_ARGUMENT, SKIP_AUTO_CLA_ARGUMENT, VERBOSE_CLA_ARGUMENT, SKIP_PRE_PROCESSING_CLA_ARGUMENT

from time import sleep
import sys

def main() -> None:
    # ensure that the CLI is standardized
    initConsole()

    claArguments = sys.argv

    # ensure that the working directory is standardized
    validateDirectoryStructure()

    if len(claArguments) < CLA_FILE_IN_POSITION + 1:
        throwError(ERROR_INVALID_ARGUMENTS_ERROR_MESSAGE)

    # cli arguments
    audioInFilePath = claArguments[CLA_FILE_IN_POSITION]

    # cli / cla arguments
    pipelineMode = PIPELINE_CLA_ARGUMENT in claArguments
    isVerbose = VERBOSE_CLA_ARGUMENT in claArguments
    isDestructive = DESTRUCTIVE_CLA_ARGUMENT in claArguments
    retainMetadata = RETAIN_METADATA_CLA_ARGUMENT in claArguments
    retainOriginal = RETAIN_ORIGINAL_CLA_ARGUMENT in claArguments
    errorAll = ERROR_ALL_CLA_ARGUMENT in claArguments
    runAuto = SKIP_AUTO_CLA_ARGUMENT not in claArguments
    forceThroughErrors = FORCE_CLA_ARGUMENT in claArguments
    allowDuplicates = ALLOW_DUPLICATES_CLA_ARGUMENT in claArguments
    skipPreProcessing = SKIP_PRE_PROCESSING_CLA_ARGUMENT in claArguments

    if pipelineMode:
        print("\tProgram is running in pipeline mode!\n\tTo terminate the program, please press Ctrl + C\n")

    while (True):
        # check that the audio file or directory exists
        if not pathExists(audioInFilePath) or forceThroughErrors:
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

                if not skipPreProcessing:
                    runAutomatedPreProcessing(fileToAnalyze)

                newInFile = fileToAnalyze

                if not retainMetadata:
                    newInFile = stripMetadata(fileToAnalyze)
                createEnvironmentVariablesCSV(newInFile, errorAll, runAuto, allowDuplicates)

                if not retainOriginal:
                    # I'm not sure if these sleep statements are needed
                    # if not, they will be removed in a future iteration
                    sleep(0.5)
                    deleteFile(fileToAnalyze)
                    sleep(0.5)
        else:
            if not skipPreProcessing:
                runAutomatedPreProcessing()

            for file in allFiles:
                allFiles = directoryFiles(audioInFilePath)

                if isVerbose:
                    print(f"Files to analyze: {allFiles}")

                newInFile = file

                if not retainMetadata:
                    newInFile = stripMetadata(file)

                createEnvironmentVariablesCSV(newInFile, errorAll, runAuto, allowDuplicates)

                if isDestructive:
                    sleep(0.5)
                    deleteFile(file)

            # since this is a CLI application, close it in a standard way
            # this is not needed, but I find it to be best practice
            closeConsole()

if __name__ == "__main__":
    main()
