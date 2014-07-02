FROM google/golang
RUN go get github.com/adriaandejonge/helloworld
RUN cd $GOPATH/github.com/adriaandejonge/helloworld
CMD docker build -t adejonge/helloworld .