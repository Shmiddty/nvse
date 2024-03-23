#!/bin/bash/
set -e
set -o pipefail

mkdir ~/nvextract

echo 'Extracting Media...'

mediaextract -q -f png -a "{index}.{ext}" -o ~/nvextract ~/.steam/steam/steamapps/common/Necrovale/hlboot.dat > /dev/null
mediaextract -q -f ascii -a "{index}.txt" -m 10k -o ~/nvextract ~/.steam/steam/steamapps/common/Necrovale/hlboot.dat > /dev/null

echo "Finding and moving the files we need..."

grep -l -Z -r '"sheets"' ~/nvextract/ | xargs -0 -I{} mv {} ./gamedata.json
grep -l -Z -r 'UI.png' ~/nvextract/ | xargs -0 -I{} mv {} ./UI.atlas
dim=$(sed -n '2p' UI.atlas | awk '{print $2,$3}' | sed 's/,/ x/')
# this is pretty fragile since more than one image could exist with these dimensions
file ~/nvextract/*.png | awk -v dim="$dim" '$0 ~ dim' | sed 's/:.*//' | tr -d '\n' | xargs -0 -I{} mv {} ./UI.png

echo "Generating CSS..."

source ./buildcss.sh

echo "Cleaning up..."

rm -rf ~/nvextract

echo "Done."
