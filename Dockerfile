FROM scratch
ADD bin/linux_amd64/helloworld /helloworld
CMD ["/helloworld"]
