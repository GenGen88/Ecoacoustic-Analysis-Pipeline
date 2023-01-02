import datetime

from util.constants import INVALID_DATE_ERROR_MESSAGE

def throwError(message: str, errorCode: int = 1) -> None:
    print(f"Runtime Error: {message}...")
    exit(errorCode)

def initConsole():
    print("\n" * 2)

def convertStringToDateTime(date: str) -> datetime.datetime:
    dateSplit = date.split("/")

    if len(dateSplit) < 3:
        throwError(INVALID_DATE_ERROR_MESSAGE)

    try:
        year = int(dateSplit[2])
        month = int(dateSplit[1])
        day = int(dateSplit[0])

        date = datetime.datetime(year, month, day)
        return date
    except:
        throwError(INVALID_DATE_ERROR_MESSAGE)

def writeToFile(filename: str, contents: str) -> None:
    with open(filename, "w") as fp:
        fp.write(contents)
        fp.close()
