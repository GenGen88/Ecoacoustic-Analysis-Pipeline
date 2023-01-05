from fetchEnvironmentalVariables.aCalendar.calendar import getAudioDate

def createEnvironmentVariablesCSV(filePath) -> None:
    print(f"Analyzing {filePath}")

    audioDate = getAudioDate(filePath)

    print(audioDate)
