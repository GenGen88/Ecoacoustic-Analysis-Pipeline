from util.util import deleteFile, isFolder, throwError, fileExists, directoryFiles, readFile
from environmentVariables.weatherData.constants import WEATHER_DATA_START_INDEX, WEATHER_FETCHER_SCRIPT_PATH
from util.constants import DIR_WEATHER_IN_FILE_PATH

import os

# combine all csv files into one big csv file in ./out/
def aggregateCSVFiles(inPath: str, outPath: str = "./out/weatherData.csv") -> str:
    if not isFolder(inPath):
        throwError(f"No input data for weather data declared.\nPlease place weather data in {DIR_WEATHER_IN_FILE_PATH}", fatal=False, errorCode=404)
        # # TODO: Genna is working on the fetcher for data
        os.system(WEATHER_FETCHER_SCRIPT_PATH)

    # remove results from previous runs
    if fileExists(outPath):
        deleteFile(outPath)

    # combine all files
    allDirectoryFiles = directoryFiles(inPath)
    totalFile = ""

    for file in allDirectoryFiles:
        # validate that the file is a csv file
        if ".csv" not in file:
            continue

        # since the weather csv files contain some comments at the top, we need to remove them before continuing
        csvRows = readFile(file)
        count = 0
        for line in csvRows.split("\n"):
            if count < WEATHER_DATA_START_INDEX:
                continue
            count += 1

            totalFile += line

    return totalFile
