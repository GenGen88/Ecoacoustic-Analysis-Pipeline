# this application assumes that the data is coming from A2O data
# the file format for A2O data contains the word "wet" or "dry" for wet and dry results
# this is a atomic heuristic and can be removed if this program is to be generalized
def isWetAudioRecording(filePath: str) -> bool:
    return "Wet" in filePath
