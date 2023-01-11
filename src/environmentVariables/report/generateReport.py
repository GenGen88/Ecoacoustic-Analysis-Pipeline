from util.util import writeToFile, pathExists, sanitizeString
from util.constants import DIR_REPORT_OUT_FILE_PATH, COLUMN_HEADERS

def generateReport(
    birdNetRows = [],
    dateRows = [],
    seasonsRows = []
) -> None:
    if not pathExists(DIR_REPORT_OUT_FILE_PATH):
        generateReportHeaders()

    for rowIndex in range(2, len(birdNetRows)):
        rowContent = f"{birdNetRows[rowIndex]},{dateRows[rowIndex]},{seasonsRows[rowIndex]}"
        rowContent = sanitizeString(rowContent)

        # # Uncomment for verbose logging
        #TODO: I need to add a --verbose flag to enable this
        # print(rowContent)
        writeToFile(DIR_REPORT_OUT_FILE_PATH, rowContent)

def generateReportHeaders() -> None:
    writeToFile(DIR_REPORT_OUT_FILE_PATH, COLUMN_HEADERS)
