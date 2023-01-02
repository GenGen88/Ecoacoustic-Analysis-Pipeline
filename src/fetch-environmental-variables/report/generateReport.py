from util.util import writeToFile

def generateReport(weatherData: str, humanDensity: str, analysisJob: str = "system") -> None:
    reportContents = f"{weatherData}, {humanDensity}"
    
    writeToFile(analysisJob, reportContents)
