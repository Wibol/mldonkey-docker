# mldonkey-docker
Dockerized mlDonkey 3.1.6 (eDonkey & Kademlia) on Ubuntu 18.04.

> This repository host the Dockerfile for building mlDonkey Docker image.
> You will need to [install Docker](https://docs.docker.com/engine/install/) first.


## Mods (07/19/2026)

- Disabled all deprecated protocols (only eDonkey and Kademlia are working).
- Replaced deprecated update URLs with emule-security.org.
- Default settings optimised for broadband without overloading the provider’s router.
- Used the “--network host” tag for container creation to avoid double NAT, thereby speeding up file sharing.
- Enabled Kademlia port 16965/TCP to access more sources.
- Optimised disk write buffer for HDDs.


## Usage

### To get the image:

    docker pull wibol/mldonkey-ubuntu

***or***

    git clone https://github.com/Wibol/mldonkey-docker.git && cd mldonkey-docker

    docker build -t wibol/mldonkey-ubuntu .


### To create the container:

    docker create --name mldonkey-ubuntu \
    --network host --restart always \
    -v "<$HOME/Downloads/mlDonkey>:/var/lib/mldonkey/incoming/files" \
    wibol/mldonkey-ubuntu

We must remove "<>" and customize its content. mlDonkey stores data inside /var/lib/mldonkey/incoming/files container directory, so we mount it on local filesystem for easy access.


### To run container:

Open 20562/tcp, 20566/udp, 16965/tcp and 16965/udp ports in your router and OS.

    docker start mldonkey-ubuntu

Then you can access mlDonkey like http://127.0.0.1:4080 :

![image](https://github.com/Wibol/mldonkey-docker/blob/main/d.png?raw=true)

> - User: admin
> - Password: Passw0rd-

Or using "mldonkey-gui" installed from your distribution repository or [Ubuntu Historical Archive](http://archive.ubuntu.com/ubuntu/pool/universe/m/mldonkey/) :


![image](https://github.com/Wibol/mldonkey-docker/blob/main/mldonkey-gui.png?raw=true)

> - User: admin
> - Password: Passw0rd-

> If you were unable to install the graphical interface due to missing packages in the repositories, there is still another way to [install mldonkey-gui and its dependencies](https://mldonkey.wibol.eu/#gui).

You can change the default password later from the telnet, web or GUI command lines:

    useradd admin <NewPassw0rd->

We must remove "<>" and customize its content. Host incomming directory is owned by "mldonkey" container user (uid=101, gid=101), so we need to change permissions for full access:

    sudo chmod -R 777 <~/Downloads/mlDonkey>

We must remove "<>" and customize its content. 


### Other optional mounts:

    -v "</var/lib/mldonkey>:/var/lib/mldonkey" \
    -v "</tmp/mldonkey>:/var/lib/mldonkey/temp" \
    -v "<$HOME/Video/mlDonkey>:/var/lib/mldonkey/shared" \
    -v "</mnt/p2pTemp/mlTemp>:/var/lib/mldonkey/temp" \
    -v "</mnt/nas/media/pub>:/var/lib/mldonkey/incoming/files" \


We must remove "<>" and customize its content. If these directories are not mounted on a different place, they will all reside on the system's root partition, which is where Docker stores data by default. Be sure you have enough free space on it.


## HDD care:

If mlDonkey’s temporary directory is located on an HDD, you can enable the disk write buffer via the command line in your graphical interface to decrease fragmentation and mechanical wear on the drive:

    set buffer_writes true


## Known problems:

When creating the container we received the error:
> Error response from daemon: create </home/wibol/Downloads/mlDonkey>: "</home/wibol/Downloads/mlDonkey>" includes invalid characters for a local volume name, only "[a-zA-Z0-9][a-zA-Z0-9_.-]" are allowed. If you intended to pass a host directory, use absolute path.

To resolve it we must remove "<>" from the local mount point.


## Links

[mlDonkey in Docker - Webpage](https://mldonkey.wibol.eu/ "mldonkey-ubuntu image web.")

[mlDonkey in Docker - GitHub](https://github.com/Wibol/mldonkey-docker "mldonkey-ubuntu image repository in GitHub.")

[mlDonkey in Docker - Linux Mint](https://forums.linuxmint.com/viewtopic.php?t=396180 "mldonkey-ubuntu installation tutorial in Linux Mint.")
