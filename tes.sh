#!/bin/bash

for dept in Marketing Engineering HR; do
    mkdir -p "/home/ramdan/Departemen/${dept}/Documents"
    mkdir -p "/home/ramdan/Departemen/${dept}/Archives"

    find /home/ramdan/Departemen/ -type f -name "${dept}_*" -not -path "*/Documents/*" \
        -exec mv {} "/home/ramdan/Departemen/${dept}/Documents/" \; 2>/dev/null

    cp "/home/ramdan/Departemen/${dept}/Documents/${dept}_*" \
        "/home/ramdan/Departemen/${dept}/Archives/" 2>/dev/null
done
