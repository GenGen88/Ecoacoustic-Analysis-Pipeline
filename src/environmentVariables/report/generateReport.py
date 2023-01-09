from util.util import writeToFile, pathExists
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
        print(rowContent)
        writeToFile(DIR_REPORT_OUT_FILE_PATH, rowContent)

def generateReportHeaders() -> None:
    writeToFile(DIR_REPORT_OUT_FILE_PATH, COLUMN_HEADERS)
