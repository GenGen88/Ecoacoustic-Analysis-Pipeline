import os

from util.constants import CONSOLE_INIT_MESSAGE, VALID_AUDIO_FILE_EXTENSIONS

def throwError(
    message: str,
    fatal: bool = True,
    errorCode: int = 1
) -> None:
    print(f"Runtime Error: {message}...")
    _=exit(errorCode) if fatal else 0

def initConsole():
    print()
    print(CONSOLE_INIT_MESSAGE)
    print("\n" * 2)
    print("Please ensure that you have run EMU on the audio files before continuing")

def closeConsole(exitCode: int = 0) -> None:
    print("\nDone!")
    exit(exitCode)

def writeToFile(path: str, contents: str) -> None:
    with open(path, "a") as fp:
        fp.write(contents)
        fp.close()

def readFile(path: str) -> str:
    with open(path, "r") as fp:
        return fp.readlines()

def deleteFile(path: str) -> bool:
    try:
        os.remove(path)
        return True
    except any as error:
        throwError(error, fatal = False)
        return False

def pathExists(path: str) -> bool:
    return os.path.exists(path)

"""
Returns if the path is a folder or file in the form of a return code
    1: The path is a folder
    0: The path is a file
    -1: The path could not be found
"""
def isFolder(path: str) -> int:
    if not pathExists(path): return -1
    return (0 if os.path.isfile(path) else 1)

def createFolder(path: str) -> bool:
    try:
        os.mkdir(path)
        return True
    except any as error:
        throwError(error, fatal = False)
        return False

def directoryFiles(path: str):
    if not isFolder(path):
        return [path]

    allFiles = os.listdir(path)
    adjustedFiles = []

    for file in allFiles:
        if isAudioFile(file):
            adjustedFiles.append(path + file)

    return adjustedFiles

def isAudioFile(fileName: str) -> bool:
    return any(ele in fileName for ele in VALID_AUDIO_FILE_EXTENSIONS)

def sanitizeString(string: str) -> str:
    newlineCharacter = "\n"
    return f"{string.replace(newlineCharacter, '')}{newlineCharacter}"

def openFile(path: str) -> bool:
    try:
        os.startfile(path)
        return True
    except any as error:
        throwError(error, fatal = False)
        return False

def fileExists(path: str) -> bool:
    return os.path.isfile(path)
