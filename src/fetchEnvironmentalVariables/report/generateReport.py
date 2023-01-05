from util.util import writeToFile

def generateReport(
    birdNetRows = None,
    dateRows = None,
    seasonsRows = None
) -> None:
    for rowIndex in range(len(birdNetRows)):
        writeToFile(f"{birdNetRows[rowIndex]},{dateRows[rowIndex]},{seasonsRows[rowIndex]}")
