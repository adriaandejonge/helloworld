function Build() {
    # The following commands build Linux/AMD64 binaries from source
    # code.  If you run them on Mac OS X or any system other than
    # Linux/AMD64, you need a Go compiler that supports
    # cross-compiling.  For how to build such a compiler, please refer
    # to https://github.com/davecheney/golang-crosscompile.
    if GOOS=linux GOARCH=amd64 go install \
    github.com/wangkuiyi/helloworld/indexer \
    github.com/wangkuiyi/helloworld/searchengine; then
        echo $'\e[32m Build for Linux/AMD64 successfully.\e[0m'
    else
        echo $'\e[31m Build for Linux/AMD64 failed.\e[0m'
        exit -1
    fi

    if cp $GOPATH/src/github.com/wangkuiyi/helloworld/Dockerfile $GOPATH/ && \
        docker build -t wangkuiyi/helloworld $GOPATH; then
        echo $'\e[32m Build Docker image successfully.\e[0m'
    else
        echo $'\e[31m Build Docker image failed.\e[0m'
        exit -1
    fi
}

function Stop() {
    docker stop searchengine
    docker rm searchengine
    docker stop indexer
    docker rm indexer
}

function Start() {
    docker run -d -p 8080:8080 --name searchengine wangkuiyi/helloworld /searchengine
    docker run -d --name indexer --link searchengine:se wangkuiyi/helloworld /indexer -searchengine=se:8080

    if [ "$(uname)" == "Drawin" ]; then
        # We are using boot2docker on Mac OS X.  We need to ask the
        # VirtualBox virtual machine to forward port 8080 of
        # searchengine to the Mac OS X host, so that we can run a Web
        # browser or other tool to check searchengine.
        VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8080,tcp,,8080,,8080";
    fi
}

function Test() {
    URL="http://localhost:8080/?q=$1"
    a=$(curl -s $URL | grep '^results:' | cut -f 2 -d ':' | sed "s/\(Some $1\) up to.*/\1/")
    if [ "$a" != "Some $1" ]; then
        echo Expecting search results matching \"Some $1\", got \"$a\"
        err=$(expr $err + 1)
    fi
}

Build
Stop
Start
sleep 1
err=0
Test "news"
Test "images"
if (( $err > 0 )); then
    echo $'\e[31m' $err tests failed. $'\e[0m'
else
    echo $'\e[32m' All tests passed. $'\e[0m'
fi
Stop
