FROM scratch
ADD $GOPATH/bin/helloworld /helloworld
CMD ["/helloworld"]