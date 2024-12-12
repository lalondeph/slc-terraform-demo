package helloworld

import (
	"encoding/json"
	"fmt"
	"html"
	"log"
	"net/http"
	"os"

	_ "github.com/GoogleCloudPlatform/functions-framework-go/funcframework"

	"github.com/GoogleCloudPlatform/functions-framework-go/functions"
)

func init() {
	functions.HTTP("HelloHTTP", helloHTTP)
}

// helloHTTP is an HTTP Cloud Function with a request parameter.
func helloHTTP(w http.ResponseWriter, r *http.Request) {
	logMsgFromYaml := os.Getenv("LOG_MSG")
	log.Printf("Variable passed in from YAML: %s", logMsgFromYaml)

	var d struct {
		Name string `json:"name"`
	}
	if err := json.NewDecoder(r.Body).Decode(&d); err != nil {
		fmt.Fprint(w, "Hello, World!")
		return
	}
	if d.Name == "" {
		fmt.Fprint(w, "Hello, World!")
		return
	}
	fmt.Fprintf(w, "Hello, %s!", html.EscapeString(d.Name))
}
