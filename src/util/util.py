def throwError(
    message: str,
    fatal: bool = True,
    errorCode: int = 1
) -> None:
    print(f"Runtime Error: {message}...")
    _=exit(errorCode) if fatal else 0

def initConsole():
    print("\n" * 2)

def writeToFile(filename: str, contents: str) -> None:
    with open(filename, "a") as fp:
        fp.write(contents)
        fp.close()

def readFile(fileName: str) -> str:
    with open(fileName, "r") as fp:
        return fp.readlines()

def pathExists(path: str):
    import os
    return os.path.exists(path)

def createFolder(path: str) -> bool:
    import os

    try:
        os.mkdir(path)
        return True
    except any as error:
        throwError(error, fatal = False)
        return False
