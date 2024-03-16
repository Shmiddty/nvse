#!/bin/bash
cwd=$PWD
cd ~/.steam/steam/steamapps/common/Necrovale/
echo "{" > gamedata.json && awk '/"sheets"/,/"compress": false/' hlboot.dat >> gamedata.json && echo "}" >> gamedata.json
mv gamedata.json $cwd
