from birdnet.birdNetAnalyses import runBirdNet
from util.calendar import generateSeasonsList, getAudioDate
from environmentVariables.report.generateReport import generateReport
from birdnet.birdNetResults import readBirdnetResults
from environmentVariables.weatherData.weatherData import getWeatherDataResult
from environmentVariables.wetDry import isWetAudioRecording

from util.constants import DIR_BIRDNET_OUT_FILE_PATH
from util.util import throwError

def createEnvironmentVariablesCSV(filePath, errorAll = False, runAuto = True) -> None:
    print(f"Analyzing {filePath}")

    runBirdNet(filePath)

    birdNetData = readBirdnetResults(DIR_BIRDNET_OUT_FILE_PATH)

    if (birdNetData == None):
        throwError("Could not find birdnet output. Your audio file may be corrupted\n", fatal=errorAll)
        return 1

    birdNetDataLength = len(birdNetData)

    audioDateData = getAudioDate(filePath, birdNetDataLength)
    seasonData = generateSeasonsList(audioDateData)

    # TODO: get weather data working
    # weatherData = getWeatherDataResult(audioDateData)

    isWetAudio = isWetAudioRecording(filePath)

    generateReport(birdNetData, audioDateData, seasonData, isWetAudio, runAuto=runAuto)
