

# idea for making one big CSV for R
# readBirdnetFile("data")[5] + weatherData()[5]
import csv

def writeBigCSV():
    f= open('birdnet.csv','w')
    writer = csv.writer(f)
    writer.writerow()
    f.close()


def readBirdnetFile(filename: str):
    birdnetRows = [] # create array to hold rows
    
    with open(filename, "r") as fp:
        filecontents = fp.readlines()
        fileLines = len(filecontents.split("\n"))

        for i in range(fileLines): # puts every row into an array
            birdnetRows.append(
                generateBirdnetRow(fileLines[i])
            )
            writeBigCSV()

    return birdnetRows

def generateBirdnetRow(content: str) -> str:
    content.replace("\t", ",")






