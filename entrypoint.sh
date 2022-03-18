#!/bin/sh

if [ ! -f /var/lib/mldonkey/downloads.ini ]; then
    mldonkey &
    echo "Waiting for mldonkey to start..."
    sleep 5
    /usr/lib/mldonkey/mldonkey_command -p "" "set client_name Dockerized-https://v.gd/cloudancer" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set client_buffer_size 5000000" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set run_as_user mldonkey" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set allowed_ips 0.0.0.0/0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_kademlia true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_bittorrent false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_overnet false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_directconnect false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_fileTP false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_hard_upload_rate 0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_hard_download_rate 0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_upload_slots 10" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-connect_only_preferred_server false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-max_connected_servers 4" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-min_left_servers 5" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-firewalled-mode false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-port 20562" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-upload_timeout 60." "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_concurrent_downloads 150" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set filenames_utf8 true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_file_mode 664" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_dir_mode 775" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_file_sparse true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urlremove http://www.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urlremove http://www.gruk.org/server.met.gz" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urlremove http://update.kceasy.com/update/fasttrack/nodes.gzip" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urlremove http://dchublist.com/hublist.config.bz2" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd server.met http://upd.emule-security.org/server.met" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd kad http://upd.emule-security.org/nodes.dat" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd guarding.p2p http://upd.emule-security.org/ipfilter.zip" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd geoip.dat http://upd.emule-security.org/ip-to-country.csv.zip" "save"
    if [ -z "$MLDONKEY_ADMIN_PASSWORD" ]; then
        /usr/lib/mldonkey/mldonkey_command -p "" "kill"
    else
        /usr/lib/mldonkey/mldonkey_command -p "" "useradd admin $MLDONKEY_ADMIN_PASSWORD"
        /usr/lib/mldonkey/mldonkey_command -u admin -p "$MLDONKEY_ADMIN_PASSWORD" "kill"
    fi
    # First port 6209 is for overnet, second 16965 for kad, we leave all the same
    sed -i '0,/   port =/s/   port =.*/  port = 6209/' /var/lib/mldonkey/donkey.ini
    sed -i '0,/   port =/s/   port =.*/  port = 16965/' /var/lib/mldonkey/donkey.ini
    sed -i 's/  port =/   port =/' /var/lib/mldonkey/donkey.ini
fi

chown -R mldonkey:mldonkey /var/lib/mldonkey

mldonkey

