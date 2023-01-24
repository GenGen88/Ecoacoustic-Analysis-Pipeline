from util.constants import CONFIG_FILE_PATH, REPLICA_SERVERS_JSON_KEY

import json
import urllib

def pickServer() -> str:
    serverList = getAllServers()

    while (True):
        for server in serverList:
            if not isReplicaBusy(server):
                return server


def isReplicaBusy(ip: str) -> bool:
    try:
        urllib.request.urlopen(f"http://{ip}/", timeout=3).readlines()
        return False
    except:
        return True

def getAllServers():
    configFP = open(CONFIG_FILE_PATH)
    configContents = json.load(configFP)
    return configContents[REPLICA_SERVERS_JSON_KEY]

def startJob(audioRecordingId: str):
    pass
