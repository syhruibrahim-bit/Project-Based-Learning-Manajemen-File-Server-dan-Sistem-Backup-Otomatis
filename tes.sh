#!/bin/bash

for dept in Marketing Engineering HR; do
    find /home/ramdan/Departemen/ -type f -name "${dept}_*" -not -path "*/Documents/*" \
        -exec mv {} "/home/ramdan/Departemen/${dept}/Documents/" \; 2>/dev/null

    cp "/home/ramdan/Departemen/${dept}/Documents/"* \
       "/home/ramdan/Departemen/${dept}/Archives/" 2>/dev/null
done
