helloworld
==========

This project serves a helloworld demo for how to use Docker to manage
a system consisting of more than one programs.

This project contains two programs -- a search engine server
(`searchengine`) and an indexer daemon (`indexer`).  `searchengine` is
an HTTP server, which accepts queries and returns search results by
looking up a data structure known as index.  It is also an RPC server,
which accepts index udpates from `indexer`, which sends new index to
`searchengine` every second.

By using this project as an example, I wrote an article,
[Docker: A Revolution](http://cxwangyi.github.io/docker.md), to show
that how to manage systems of micro-service architecture.
