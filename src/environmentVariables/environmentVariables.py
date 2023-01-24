from birdnet.birdNetAnalyses import runBirdNet
from util.calendar import generateSeasonsList, getAudioDate
from environmentVariables.report.generateReport import generateReport
from birdnet.birdNetResults import readBirdnetResults
from environmentVariables.weatherData.weatherData import getWeatherDataResult

from util.constants import DIR_BIRDNET_OUT_FILE_PATH

def createEnvironmentVariablesCSV(filePath) -> None:
    print(f"Analyzing {filePath}")

    runBirdNet(filePath)

    birdNetData = readBirdnetResults(DIR_BIRDNET_OUT_FILE_PATH)
    birdNetDataLength = len(birdNetData)

    audioDateData = getAudioDate(filePath, birdNetDataLength)
    seasonData = generateSeasonsList(audioDateData)

    weatherData = getWeatherDataResult(audioDateData)

    generateReport(birdNetData, audioDateData, seasonData, weatherData)
