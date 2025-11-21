

for dept in Marketing Engineering HR; do
    # Memindahkan file yang namanya diawali nama departemen ke folder Documents
    find /home/ramdan/Departemen/ -type f -name "${dept}_*" -not -path "*/Documents/*" \
        -exec mv {} "/home/ramdan/Departemen/${dept}/Documents/" \; 2>/dev/null

    # Menyalin file dari Documents ke Archives
    cp "/home/ramdan/Departemen/${dept}/Documents/${dept}_*" \
        "/home/ramdan/Departemen/${dept}/Archives/" 2>/dev/null
done
