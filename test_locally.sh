function Build() {
    if go install github.com/wangkuiyi/helloworld/indexer && \
        go install github.com/wangkuiyi/helloworld/searchengine; then
        echo $'\e[32m Build successfully.\e[0m'
    else
        echo $'\e[31m Build failed.\e[0m'
        exit -1
    fi
}

function Stop() {
    killall indexer 2> /dev/null
    killall searchengine 2> /dev/null
}

function Start() {
    $GOPATH/bin/searchengine -addr=":8080" &
    $GOPATH/bin/indexer -searchengine=":8080" &
}

function Test() {
    URL="http://localhost:8080/?q=$1"
    a=$(curl -s $URL | grep '^results:' | cut -f 2 -d ':' | sed "s/\(Some $1\) up to.*/\1/")
    if [ "$a" != "Some $1" ]; then
        echo Expecting search results matching \"Some $1\", got \"$a\"
        err=1
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
