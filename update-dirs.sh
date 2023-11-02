#!/bin/bash

# Used every month to update my dirs and the soft links in the home directory

bases="work temp personal/temp"
links="docs work_temp personal_temp"
links=($links)

year=$(date +%Y)
month=$(date +%b | tr '[:upper:]' '[:lower:]')

i=0
for base in $bases
do
    echo "Base dir: $base"
    if [ ! -d $base/$year ]; then mkdir $base/$year ; fi
    full=$base/$year/$month
    if [ ! -d $full ]; then mkdir $full ; fi
    echo "Creating link named: "${links[$i]}" to dir: "$full
    ln -shfv $full ${links[$i]}
    i=$((i+1))
done

echo "updated to the new month! "
