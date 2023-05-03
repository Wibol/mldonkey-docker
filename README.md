# mldonkey-docker
Dockerized mlDonkey 3.1.6 on Ubuntu 18.04 in 90MB image (only eDonkey and Kademlia). This repository host the Dockerfile for building mlDonkey Docker image.

Every day it is more complicated to install mlDonkey due to its lack of maintenance and the difficulty to find everything we need in our operating system. One way to continue enjoying this magnificent p2p program is to run it inside a Docker container and on a platform on which it worked well. This keeps it isolated from the operating system installed on your computer, which will keep it running for years to come.

You will need to [install Docker](https://docs.docker.com/engine/install/) first.


## Mods

- Disabled all deprecated protocols.
- Replaced deprecated update URLs with emule-security.org.
- Increased "client_buffer_size" to 5000000 for bandwidth optimisation.
- Increased "max_upload_slots" to 10 for easier sharing.
- Decreased "ED2K-upload_timeout" to 60 to avoid queues full of idle clients.


## Usage

### To get the image:

    docker pull wibol/mldonkey-ubuntu

***or***

    git clone https://github.com/Wibol/mldonkey-docker.git && cd mldonkey-docker

    docker build -t wibol/mldonkey-ubuntu .


### To create the container:

    docker create --name mldonkey-ubuntu --restart=always \
    -p 4080:4080 -p 4000:4000 -p 4001:4001 \
    -p 20562:20562 -p 20566:20566/udp -p 16965:16965/udp \
    -v "<$HOME/Downloads/mlDonkey>:/var/lib/mldonkey/incoming/files" \
    wibol/mldonkey-ubuntu

We must remove "<>" and customize its content. mlDonkey stores data inside /var/lib/mldonkey/incoming/files container directory, so we mount it on local filesystem for easy access.


### To run container:

Open 20562/tcp, 20566/udp and 16965/udp ports in your router and OS.

    docker start mldonkey-ubuntu

Then you can access mlDonkey like http://127.0.0.1:4080 or using "mldonkey-gui" installed from your distro repo.

- User: admin
- Password: Passw0rd-

![image](https://github.com/Wibol/mldonkey-docker/blob/main/d.png)

You can change the default password later from the telnet, web or GUI command lines:

    useradd admin <NewPassw0rd->

We must remove "<>" and customize its content. Incomming directory is owned by "mldonkey" container user (uid=101, gid=101), so we need to change permissions for full access:

    sudo chmod -R 777 <~/Downloads/mlDonkey>

We must remove "<>" and customize its content. 


### Other optional mounts:

    -v "</var/lib/mldonkey>:/var/lib/mldonkey" \
    -v "</tmp/mldonkey>:/var/lib/mldonkey/temp" \
    -v "<$HOME/Video/mlDonkey>:/var/lib/mldonkey/shared" \

We must remove "<>" and customize its content. If these directories are not mounted on a different place, they will all reside on the system's root partition, which is where Docker stores data by default. Be sure you have enough free space on it.

## Known problems:

When creating the container we received the error:
> Error response from daemon: create </home/wibol/Downloads/mlDonkey>: "</home/wibol/Downloads/mlDonkey>" includes invalid characters for a local volume name, only "[a-zA-Z0-9][a-zA-Z0-9_.-]" are allowed. If you intended to pass a host directory, use absolute path.

To resolve it we must remove "<>" from the local mount point.

## Links:

[mlDonkey in Docker - Webpage](https://mldonkey.wibol.eu/ "mldonkey-ubuntu image web.")

[mlDonkey in Docker - Docker](https://hub.docker.com/r/wibol/mldonkey-ubuntu "mldonkey-ubuntu image repository in Docker.")

[mlDonkey in Docker - Linux Mint](https://forums.linuxmint.com/viewtopic.php?t=396180 "mldonkey-ubuntu installation tutorial in Linux Mint.")
