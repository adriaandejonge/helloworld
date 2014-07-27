package main

import (
	"flag"
	"fmt"
	"net/http"
	"net/rpc"
)

var (
	addr = flag.String("addr", ":8080", "Address of serach engine")
)

type SearchEngine struct {
	index map[string]string
}

func main() {
	flag.Parse()
	var se SearchEngine
	rpc.Register(se)
	rpc.HandleHTTP()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		q := r.URL.Query()["q"]
		if len(q) > 0 {
			fmt.Fprintf(w, "query: %s\nresults:%s", q[0], se.index[q[0]])
		}
	})
	fmt.Printf("Started, serving at %s", *addr)
	if e := http.ListenAndServe(*addr, nil); e != nil {
		panic("ListenAndServe: " + e.Error())
	}
}
