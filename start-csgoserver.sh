#!/usr/bin/env bash

cd /home/csgo

echo "Checking for updates..."
echo "INFO: This might take a while espacially for the first run!"
STEAMCMD_EXIT=-1
while
    ./steamcmd.sh +login anonymous +force_install_dir /home/csgo/data/ +app_update 740 +quit > /dev/null
    STEAMCMD_EXIT="$?"

    if [ "$STEAMCMD_EXIT" == "7" ]; then
        echo "WARNING: Not enough disk space!"
        exit -1;
    elif [ "$STEAMCMD_EXIT" == "8" ]; then
        echo "Retrying to update (steamcmd.sh exit status was ${STEAMCMD_EXIT})"
    fi

    [ "$STEAMCMD_EXIT" -eq "8" ]
do :;  done

# default settings
test -z "${MAP+x}" && MAP="de_dust2"
test -z "${GAME_MODE+x}" && GAME_MODE="COMPETITIVE"
test -z "${MAXPLAYERS+x}" && MAXPLAYERS="10"


test -n "${MAXPLAYERS}" && MAXPLAYERS_CMD="-maxplayers_override ${MAXPLAYERS}"
test -n "${AUTH_KEY}" && AUTH_KEY_CMD="-authkey ${AUTH_KEY}"
test -n "${MAP}" && MAP_CMD="+map ${MAP}"
test -n "${STEAM_ACCOUNT}" && STEAM_ACCOUNT_CMD="+sv_setsteamaccount ${STEAM_ACCOUNT}"

if [ "$GAME_MODE" == "CASUAL" ]; then
    GAME_MODE_CMD="+game_type 0 +game_mode 0"
elif [ "$GAME_MODE" == "COMPETITIVE" ]; then
    GAME_MODE_CMD="+game_type 0 +game_mode 1"
elif [ "$GAME_MODE" == "ARMS_RACE" ]; then
    GAME_MODE_CMD="+game_type 1 +game_mode 0"
elif [ "$GAME_MODE" == "DEMOLITION" ]; then
    GAME_MODE_CMD="+game_type 1 +game_mode 1"
fi

echo "#######################################################"
echo "Starting up CS:GO Server..."

./data/srcds_run -game csgo -usercon -nobots -tickrate 128 -ip 0.0.0.0 ${MAXPLAYERS_CMD} ${AUTH_KEY_CMD} ${MAP_CMD} ${STEAM_ACCOUNT_CMD} ${GAME_MODE_CMD}
