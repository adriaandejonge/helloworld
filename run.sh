./build.sh
docker run -d -p 8080:8080 wangkuiyi/helloworld /helloworld -greeting=gopher-on-docker
docker run -d -p 8081:8080 wangkuiyi/helloworld /helloworld -greeting=another-gopher-on-docker
