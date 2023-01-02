import sys
import datetime

from weatherData.fetchWeatherData import fetchWeatherData
from util.util import throwError, initConsole, convertStringToDateTime
from util.constants import INVALID_ARGUMENTS_ERROR_MESSAGE

def main() -> None:
    initConsole()

    if len(sys.argv) < 2:
        throwError(INVALID_ARGUMENTS_ERROR_MESSAGE)

    dateString = sys.argv[1]

    date = convertStringToDateTime(dateString)

    print(date)

main()
