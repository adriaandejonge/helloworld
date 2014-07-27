package main

import (
	"flag"
	"fmt"
	"log"
	"net/rpc"
	"time"
)

var (
	se = flag.String("searchengine", "", "Address of search engine server")
)

func main() {
	flag.Parse()
	for {
		time.Sleep(1 * time.Second)

		c, e := rpc.DialHTTP("tcp", *se)
		if e != nil {
			log.Fatal("dialing:", e)
		}

		index := map[string]string{
			"news":   fmt.Sprint("Some news up to ", time.Now()),
			"images": fmt.Sprint("Some images up to", time.Now()),
		}
		var a int
		if e := c.Call("SearchEngine.UpdateIndex", index, &a); e != nil {
			log.Printf("Failed update index: %v", e)
		}
		c.Close()
	}
}
