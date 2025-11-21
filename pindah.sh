for dept in Marketing Engineering HR; do
    # find untuk mencari file berdasarkan awalan nama departemen dan exec = mengeksekusi mv untuk memindahkan ke departemen yang sesuai
    find -type f -name /home/departemen/"${dept}_*" -not -path "*/Documents/*" -exec mv {} /home/departemen/${dept}/Documents/ \; 2>/dev/null

    # cp untuk menyalin untuk membackup ke folder Archives
    cp /home/departemen/${dept}/Documents/${dept}_* /home/departemen/${dept}/Archives/
done
