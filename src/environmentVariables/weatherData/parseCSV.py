from src.util.util import deleteFile, isFolder, throwError, fileExists, directoryFiles, readFile
from src.environmentVariables.weatherData.constants import WEATHER_DATA_START_INDEX

# combine all csv files into one big csv file in ./out/
def aggregateCSVFiles(inPath: str, outPath: str = "./out/weatherData.csv") -> str:
    if not isFolder(inPath):
        throwError(f"{inPath} is not a recognised path", errorCode=404)

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
        count = WEATHER_DATA_START_INDEX
        for line in csvRows:
            count += 1
            print("Line{}: {}".format(count, line.strip()))
    
    return totalFile
