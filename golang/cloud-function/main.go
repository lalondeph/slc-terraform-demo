package cloud_function
//
//import (
//	"context"
//	"log"
//	"os"
//)
//
//// Entry point for the cloud function
//func HandleRequest(ctx context.Context) error {
//	log.Println("Cloud function executed successfully.")
//
//	logMsgFromYaml := os.Getenv("LOG_MSG")
//	log.Printf("Variable passed in from YAML: %s", logMsgFromYaml)
//
//	return nil
//}
//


// Sample run-helloworld is a minimal Cloud Run service.
//package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	log.Print("starting server...")
	http.HandleFunc("/", handler)

	// Determine port for HTTP service.
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("defaulting to port %s", port)
	}

	// Start HTTP server.
	log.Printf("listening on port %s", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		log.Fatal(err)
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	name := os.Getenv("NAME")
	if name == "" {
		name = "World"
	}
	fmt.Fprintf(w, "Hello %s!\n", name)
}
