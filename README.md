# docker_logitech-media-server
docker-files for legacy versions of Logitech Media Center

docker hub: https://hub.docker.com/r/c64emu/logitechmediaservers/

Build system for running legacy versions of the Logitech
- Slimserver /
- SqueezeCenter (SC) /    
- Squeezebox Server (SBS) /    
- Media Server (LMS)
    
  on newer linux os versions (omitting conflicting perl versions).

To use, e.g. for SqueezeCenter v7.2.1:
```
$ docker pull c64emu/logitechmediaservers:SC-7_2_1
```

- add user AND group on hostsystem: "squeezecenter", ID: 888
- create volumes on hostsystem (owner: squeezecenter:squeezecenter; permissions: 755)
    - SQUEEZE_VOL (for cache, logfiles and prefs): /srv/squeezebox
    - SQUEEZE_MEDIA (for the mediafiles): /media/Audio

 - review and where required, customize SqueezeCenter by motifying "start-squeezebox.sh", "entrypoint.sh" and "Dockerfile".
  Note: the "server.prefs" is customized to use a MySQL-DB.

```
$ docker run -d \
           --name=SC-7_2_1 \
           -h SqueezeCenter \
           -p 9000:9000 \
           -p 9090:9090 \
           -p 3483:3483 \
           -v /home/docker/DockerImages/SC-7_2_1/srv_squeezeboxserver:/srv/squeezebox \
           -v /home/public/lan/Fun/Audio:/media/Audio:ro \
           c64emu/logitechmediaservers:SC-7_2_1
```
