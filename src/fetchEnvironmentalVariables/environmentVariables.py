from birdnet.birdNet import runBirdNet
from fetchEnvironmentalVariables.aCalendar.calendar import generateSeasonsList, getAudioDate
from fetchEnvironmentalVariables.report.generateReport import generateReport
from fetchEnvironmentalVariables.report.speciesAdujusted import readBirdnetFile

def createEnvironmentVariablesCSV(filePath) -> None:
    print(f"Analyzing {filePath}")

    runBirdNet(filePath)

    birdNetData = readBirdnetFile()
    audioDateData = getAudioDate(filePath)
    seasonData = generateSeasonsList(audioDateData)

    generateReport(birdNetData, audioDateData, seasonData)
