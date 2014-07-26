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

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from %s", *greeting)
}

func main() {
	flag.Parse()
	http.HandleFunc("/", helloHandler)

	fmt.Printf("Started, serving at %s", *addr)
	err := http.ListenAndServe(*addr, nil)
	if err != nil {
		panic("ListenAndServe: " + err.Error())
	}
}
