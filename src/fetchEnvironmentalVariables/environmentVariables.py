from birdnet.birdNet import runBirdNet
from fetchEnvironmentalVariables.calendarComponent.calendar import generateSeasonsList, getAudioDate
from fetchEnvironmentalVariables.report.generateReport import generateReport
from fetchEnvironmentalVariables.report.speciesAdujusted import readBirdnetFile

from util.constants import DIR_BIRDNET_OUT_FILE_PATH

def createEnvironmentVariablesCSV(filePath) -> None:
    print(f"Analyzing {filePath}")

    runBirdNet(filePath)

    birdNetData = readBirdnetFile(DIR_BIRDNET_OUT_FILE_PATH)
    birdNetDataLength = len(birdNetData)

    audioDateData = getAudioDate(filePath, birdNetDataLength)
    seasonData = generateSeasonsList(audioDateData)

    generateReport(birdNetData, audioDateData, seasonData)
