for dept in Marketing Engineering HR; do
    find -type f -name /home/ramdan/Departemen/"${dept}_*" -not -path "*/Documents/*" -exec mv {} /home/ramdan/Departemen/${dept}/Documents/ \; 2>/dev/null

    cp /home/ramdan/Departemen/${dept}/Documents/${dept}_* /departemen/${dept}/Archives/
done
