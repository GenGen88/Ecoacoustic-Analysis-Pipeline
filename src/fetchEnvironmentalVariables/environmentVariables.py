from calendar.calendar import getAudioDate

def createEnvironmentVariablesCSV(filePath) -> None:
    print(f"Analyzing {filePath}")

    dateTime = getAudioDate(filePath)

    print(dateTime)
