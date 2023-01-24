from util.constants import CONFIG_FILE_PATH, REPLICA_SERVERS_JSON_KEY

import json

def pickServer() -> str:
    configFP = open(CONFIG_FILE_PATH)

    configContents = json.load(configFP)

    while (True):
        for server in configContents[REPLICA_SERVERS_JSON_KEY]:
            if not isReplicaBusy(server):
                return server


def isReplicaBusy(ip: str) -> bool:
    return False

def getAllServers():
    pass
