def readBirdnetResults(filename: str):
    birdNetRows = [] # create array to hold rows

    with open(filename, "r") as fp:
        fileLines = fp.readlines()
        fileLinesCount = len(fileLines)

        for i in range(fileLinesCount): # puts every row into an array
            birdNetRows.append(
                generateBirdnetRow(fileLines[i])
            )

    return birdNetRows

def generateBirdnetRow(content: str) -> str:
    return content.replace("\t", ",")
