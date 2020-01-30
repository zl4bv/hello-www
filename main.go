package main

import (
	"io"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", rootHandler)
	log.Println("Listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func rootHandler(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, `<!DOCTYPE html>
	<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1">
	<title>Hello, World Wide Web!</title>
	</head>
	<body>
		<h1>Hello, World Wide Web!</title>
	</body>
	</html>
	`)
}
