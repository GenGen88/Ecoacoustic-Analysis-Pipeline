from util.util import writeToFile, pathExists, sanitizeString, runCommand
from util.constants import DIR_REPORT_OUT_FILE_PATH, COLUMN_HEADERS, DIR_TOTAL_REPORT_OUT_FILE_PATH

import os

def generateReport(
    birdNetRows = [],
    dateRows = [],
    seasonsRows = [],
    isWetAudio = False,
    weatherRows = []
) -> None:
    if not pathExists(DIR_REPORT_OUT_FILE_PATH):
        generateReportHeaders()

    for rowIndex in range(2, len(birdNetRows)):
        rowContent = f"{birdNetRows[rowIndex]},{dateRows[rowIndex]},{seasonsRows[rowIndex]},{isWetAudio}"
        rowContent = sanitizeString(rowContent)

        # # Uncomment for verbose logging
        # TODO: I need to add a --verbose flag to enable this
        # print(rowContent)
        writeToFile(DIR_REPORT_OUT_FILE_PATH, rowContent)

    # TODO: this should technically not be in here, but this is good enough for now
    # open the results text file in the users specified text editor
    # openFile(DIR_REPORT_OUT_FILE_PATH)
    # cleanUpReport()

def generateReportHeaders() -> None:
    writeToFile(DIR_REPORT_OUT_FILE_PATH, COLUMN_HEADERS)

# sometimes there are double up reports, therefore, remove it
def cleanUpReport() -> None:
    runCommand(f"./cleanUpReport.sh {DIR_REPORT_OUT_FILE_PATH} {DIR_TOTAL_REPORT_OUT_FILE_PATH}")
