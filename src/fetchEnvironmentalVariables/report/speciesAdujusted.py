# idea for making one big CSV for R
# readBirdnetFile("data")[5] + weatherData()[5]

def readBirdnetFile(filename: str):
    birdNetRows = [] # create array to hold rows
    
    with open(filename, "r") as fp:
        fileContents = fp.readlines()
        fileLines = len(fileContents.split("\n"))

        for i in range(fileLines): # puts every row into an array
            birdNetRows.append(
                generateBirdnetRow(fileLines[i])
            )

    return birdNetRows

def generateBirdnetRow(content: str) -> str:
    content.replace("\t", ",")
