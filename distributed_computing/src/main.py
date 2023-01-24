from util.constants import ENTRY_POINT_PROGRAM_ERROR
from servers import pickServer

if __name__ == "__main__":
    avalibleServer = pickServer()
    print(avalibleServer)
else:
    print(ENTRY_POINT_PROGRAM_ERROR)
