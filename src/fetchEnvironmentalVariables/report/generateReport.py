from util.util import writeToFile

def generateReport(
    birdNetRows = [],
    dateRows = [],
    seasonsRows = []
) -> None:
    for rowIndex in range(len(birdNetRows)):
        writeToFile(f"{birdNetRows[rowIndex]},{dateRows[rowIndex]},{seasonsRows[rowIndex]}")
