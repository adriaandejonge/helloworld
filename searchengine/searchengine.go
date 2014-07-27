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

func (se *SearchEngine) UpdateIndex(index map[string]string, _ *int) error {
	se.index = index
	return nil
}

func main() {
	flag.Parse()
	se := new(SearchEngine)
	rpc.Register(se)
	rpc.HandleHTTP()

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		q := r.URL.Query()["q"]
		if len(q) > 0 {
			fmt.Fprintf(w, "query: %s\nresults:%s", q[0], se.index[q[0]])
		}
	})

	if e := http.ListenAndServe(*addr, nil); e != nil {
		panic("ListenAndServe: " + e.Error())
	}
}
