#!/bin/sh

if [ ! -f /var/lib/mldonkey/downloads.ini ]; then
    mldonkey &
    echo "Waiting for mldonkey to start..."
    sleep 5
    /usr/lib/mldonkey/mldonkey_command -p "" "set client_name https://hub.docker.com/r/wibol/mldonkey-ubuntu" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set client_buffer_size 5000000" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set run_as_user mldonkey" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set allowed_ips 0.0.0.0/0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_kademlia true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_bittorrent false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_overnet false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_directconnect false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set enable_fileTP false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_hard_upload_rate 30000" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_hard_download_rate 0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_upload_slots 10" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_concurrent_downloads 5" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_connections_per_second 6" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_opened_connections 300" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set max_indirect_connections 45" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-min_left_servers 5" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-port 20562" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-upload_timeout 60" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-keep_downloaded_in_old_files true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-max_sources_per_file 100" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set ED2K-check_client_connections_delay 240" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set filenames_utf8 true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_file_mode 664" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_dir_mode 775" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set create_file_sparse true" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set buffer_writes false" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set buffer_writes_delay 120" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "set buffer_writes_threshold 65536" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urlremove http://www.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urlremove http://www.gruk.org/server.met.gz" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urlremove http://update.kceasy.com/update/fasttrack/nodes.gzip" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urlremove http://dchublist.com/hublist.config.bz2" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "rem all" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd server.met http://upd.emule-security.org/server.met 25" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd kad http://upd.emule-security.org/nodes.dat 0" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd guarding.p2p http://upd.emule-security.org/ipfilter.zip 250" "save"
    /usr/lib/mldonkey/mldonkey_command -p "" "urladd geoip.dat http://upd.emule-security.org/ip-to-country.csv.zip 0" "save"
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
