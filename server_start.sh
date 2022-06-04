#!/bin/bash
logfile="/var/log/peon/${0##*/}.log"
rootpath="/home/steam/steamcmd/"
cd $rootpath
echo "" > $logfile
# Logging config start - capture all
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>$logfile 2>&1
# Logging config end
echo "##################### STARTING SERVER ######################"
# CUSTOM GAME SERVER COMMAND
echo "Clean existing /tmp/.X0-lock"
rm -rf /tmp/.X0-lock 2>&1
echo " "
echo "Starting Xvfb"
Xvfb :0 -screen 0 1024x768x16 &
echo "Start server"
DISPLAY=:0.0 wine64 data/VRisingServer.exe -persistentDataPath /home/steam/steamcmd/peon/config -serverName "$SERVERNAME" -saveName "$WORLDNAME" -logFile "/var/log/peon/server.log" "$GAMEPORT" "$QUERYPORT" 2>&1
