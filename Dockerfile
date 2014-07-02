FROM scratch
ADD /gopath/bin/helloworld /helloworld
CMD ["/helloworld"]