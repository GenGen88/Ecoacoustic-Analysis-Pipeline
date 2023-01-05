import datetime


def getSeason(date : datetime) -> str:
    if date.month == 12 or 1 or 2: # December, January, February
        return "summer"
    if date.month == 3 or 4 or 5: # March, April, May
        return "autumn"
    if date.month == 6 or 7 or 8: # June, July, August
        return "winter"
    if date.month == 9 or 10 or 11: # September, October, November
        return "spring"

def getAudioDate(fileName: str) -> datetime:
    DATE_INDEX: int = 5
    
    date = fileName.split("_")[DATE_INDEX]

    year = date[0:4]
    month = date[4:6]
    day = date[6:8]

    return f" {day}/{month}/{year}"
