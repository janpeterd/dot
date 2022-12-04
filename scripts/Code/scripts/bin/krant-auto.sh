#!/bin/bash

kranten=("DeTijd" "GazetvanAntwerpen/GazetvanAntwerpenKempen" "DeStandaard/DeStandaardAntwerpen" "DeMorgen" "HetLaatsteNieuws/HetLaatsteNieuwsKempen" "HetNieuwsblad/HetNieuwsbladKempen" "HetBelangvanLimburg/HetBelangvanLimburgGenk")
mount_dir="/home/jp/Code/scripts/krant_auto/gopress/"
pdf_dir="$mount_dir/gopress/pdf"
sync_dir="/home/jp/synced/Sync-krant"

sudo curlftpfs -o allow_other -o direct_io jbollansee:8d01w!@ftp-production.gopress.be $mount_dir

rm -rf /tmp/kranten_data
mkdir /tmp/kranten_data

# loop
for krant in ${kranten[@]}
do
    echo "cd to $krant"
    cd "$pdf_dir/$krant"
    pwd

    echo "cd to latest year (starts with 20)"
    cd  "$(\ls -1dt ./*/ | grep "20" | head -n 1)"

    echo "cd to latest month"
    cd  "$(\ls -1dt ./*/ | head -n 1)"

    echo "cd to latest day"
    cd  "$(\ls -1dt ./*/ | head -n 1)"

    echo "copy *.zip to tmp-dir"

    cp *.zip /tmp/kranten_data

    echo "cd tmp"

    cd /tmp/kranten_data/
    echo "unzip"
    unzip *.zip
    echo "pages to output.pdf"
    filename=$(echo "$krant" | sed -e 's/[^A-Za-z0-9._-]/_/g')
    qpdf --empty --pages *.pdf -- $filename.pdf
    echo "copy output to sync"
    cp -f /tmp/kranten_data/$filename.pdf $sync_dir

    echo "delete all pdf pages except krant"
    find . ! -name "$filename.pdf" -type f -exec rm -f {} +
    rm -rfv /tmp/kranten_data/*
done

sudo umount -l $mount_dir
