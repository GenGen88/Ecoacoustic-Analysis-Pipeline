from environmentVariables.weatherData.parseCSV import aggregateCSVFiles
from util.constants import DIR_WEATHER_IN_FILE_PATH, DIR_WEATHER_OUT_FILE_PATH
from util.util import fileExists, readFile

from pandas import *

# get weather data
# returns a csv containing all weather data
def getAllWeatherData() -> str:
    # use a cached version of weather data if it exists
    if not fileExists(DIR_WEATHER_OUT_FILE_PATH):
        # combine all csv files into one big csv file
        aggregateCSVFiles(DIR_WEATHER_IN_FILE_PATH, DIR_WEATHER_OUT_FILE_PATH)

    return readFile(DIR_WEATHER_OUT_FILE_PATH)

# gets weather data for a specific day
def getDayWeather(dateToFind: str) -> str:
    # instantiate the weather data csv
    getAllWeatherData()
    data = read_csv(DIR_WEATHER_IN_FILE_PATH)

    weatherForDay = data.loc(data["date"] == dateToFind)
    
    if (not weatherForDay == None and not weatherForDay == [] and not weatherForDay == ""):
        return weatherForDay
    else:
        return ""

def getWeatherDataResult(audioDateData):
    weatherDataResults = []

    for date in audioDateData:
        weatherDataResults.append(
            getDayWeather(date)
        )
    
    return weatherDataResults
