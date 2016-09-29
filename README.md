# docker-csgoserver

A simple Counter Strike: Global Offensive server without any voodoo

## Usage

#### Get latest image

    docker pull methanol/docker-csgoserver:latest

#### Enable metamod and sourcemod

To enable metamod and sourcemod you habe to add `SOURCEMOD=true` to the environment

    docker run -e SOURCEMOD=true ... methanol/docker-csgoserver

After enabling sourcemod you should have two new folders - `/home/csgo/data/csgo/adddons` and  `/home/csgo/data/csgo/cfg`.

#### Set GSLT (Game Server Login Token)

Without specifying a GSLT the server will be restricted to LAN connections only. Go to https://steamcommunity.com/dev/managegameservers and create a GSLT.

    docker run -e GSLT="<your-gslt-here>" ... methanol/docker-csgoserver

Setting the GSLT is as simple as adding an environment variable

#### Set Web API Key

To be able to host workshop maps you have to specify a Web API Key. Visit https://steamcommunity.com/dev/apikey and create a Web API Key.

Like setting the GSLT just add another environment variable for the Web API Key.

    docker run -e WEB_API_KEY="<your-web-api-key-here>" ... methanol/docker-csgoserver

#### Run server with minimal settings

    docker run -e GSLT="<your-gslt-here> -p 27015:27015/tcp -p 27015:27015/udp -d methanol/docker-csgoserver

#### Run server with more advanced settings

    docker run -e GSLT="<your-gslt-here" -e WEB_API_KEY="<your-web-api-key-here>" -e MAP="de_cache" -e MAXPLAYERS="12" GAME_MODE="CASUAL" -p 27015:27015/tcp -p 27015:27015/udp -v /home/csgo/server1:/home/csgo/data -d --name="csgoserver" methanol/docker-csgoserver

Make sure that the owner of /home/csgo/server1 is csgo (uid=1000, gid=1000) if you want to mount a volume into the container.

    chown 1000:1000 /home/csgo/server1

### TODO

* GOTV enable
