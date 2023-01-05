from util.util import writeToFile
from util.constants import DIR_REPORT_OUT_FILE_PATH

def generateReport(
    birdNetRows = [],
    dateRows = [],
    seasonsRows = []
) -> None:
    for rowIndex in range(len(birdNetRows)):
        writeToFile(DIR_REPORT_OUT_FILE_PATH, f"{birdNetRows[rowIndex]},{dateRows[rowIndex]},{seasonsRows[rowIndex]}")
