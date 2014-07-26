GOOS=linux GOARCH=amd64 go install
docker build -t wangkuiyi/helloworld $GOPATH
