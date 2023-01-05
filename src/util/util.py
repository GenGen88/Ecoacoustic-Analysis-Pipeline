def throwError(message: str, errorCode: int = 1) -> None:
    print(f"Runtime Error: {message}...")
    exit(errorCode)

def initConsole():
    print("\n" * 2)

def writeToFile(filename: str, contents: str) -> None:
    with open(filename, "w") as fp:
        fp.write(contents)
        fp.close()

def readFile(fileName: str) -> str:
    with open(fileName, "r") as fp:
        return fp.readlines()

def pathExists(path: str):
    import os
    return os.path.exists(path)
