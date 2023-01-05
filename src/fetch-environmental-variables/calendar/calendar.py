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
    
