cw-mono-sandbox
===============
Install steps:

Use docker.txt to build a docker.io container:

    docker build -t <image:tag> https://github.com/ssineriz/cw-mono-sandbox/raw/master/dockerfile.txt

start container:

    sudo docker run -d -p 7777 <image:tag>

check exported ip ports

    sudo docker ps
