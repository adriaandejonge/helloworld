FROM google/golang
RUN go get github.com/adriaandejonge/helloworld
RUN cd /
CMD docker build -t adejonge/helloworld $GOPATH/src/github.com/adriaandejonge/helloworld