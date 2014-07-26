package main

import (
	"flag"
	"fmt"
	"net/http"
)

var (
	addr     = flag.String("addr", ":8080", "The network address")
	greeting = flag.String("greeting", "helloworld", "Greeting message")
)

func main() {
	flag.Parse()
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello from %s", *greeting)
	})
	fmt.Printf("Started, serving at %s", *addr)
	if e := http.ListenAndServe(*addr, nil); e != nil {
		panic("ListenAndServe: " + e.Error())
	}
}
