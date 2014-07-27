./build_locally.sh
killall searchengine
killall indexer
$GOPATH/bin/searchengine -addr=":8080" &
$GOPATH/bin/indexer -searchengine=":8080"
