for dept in Marketing Engineering HR; do
    find /home/ramdan/Departemen/ -type f -name "${dept}_*" -not -path "*/Documents/*" -exec mv {} "/home/ramdan/Departemen/${dept}/Documents/" \;

    cp "/home/ramdan/Departemen/${dept}/Documents/"* "/home/ramdan/Departemen/${dept}/Archives/" 
done
