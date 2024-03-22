#!/bin/bash/

mkdir ~/nvextract
mediaextract -q -f ascii -a "{index}.txt" -m 10k -o ~/nvextract ~/.steam/steam/steamapps/common/Necrovale/hlboot.dat
mediaextract -q -f png -a "{index}.{ext}" -o ~/nvextract ~/.steam/steam/steamapps/common/Necrovale/hlboot.dat
