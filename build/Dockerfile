FROM google/golang
RUN go get github.com/adriaandejonge/helloworld
CMD cp $GOPATH/src/github.com/adriaandejonge/helloworld/Dockerfile .
CMD docker build -t adejonge/helloworld .