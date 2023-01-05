from util.util import pathExists, createFolder, throwError
from util.constants import DIR_OUT_DIRECTORY

def validateDirectoryStructure() -> None:
    if not pathExists(DIR_OUT_DIRECTORY):
        throwError("Out directory not found", fatal=False)
        print(f"\tCreating {DIR_OUT_DIRECTORY}")
        createFolder(DIR_OUT_DIRECTORY)
