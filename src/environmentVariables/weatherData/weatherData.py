from src.environmentVariables.weatherData.parseCSV import aggregateCSVFiles
from src.util.constants import DIR_WEATHER_IN_FILE_PATH, DIR_WEATHER_OUT_FILE_PATH
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
def getDayWeatherData() -> str:
    allWeatherData = getAllWeatherData()
    data = read_csv(DIR_WEATHER_IN_FILE_PATH)

    dates = data["Date"]

    i = 0
