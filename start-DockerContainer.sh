docker run -d \
           --name=SC-7_2_1 \
           -h SqueezeCenter \
           -p 9000:9000 \
           -p 9090:9090 \
           -p 3483:3483 \
           -v /home/docker/DockerImages/SC-7_2_1/srv_squeezeboxserver:/srv/squeezebox \
           -v /home/public/lan/Fun/Audio:/media/Audio:ro \
           c64emu/logitechmediaservers:SC-7_2_1

