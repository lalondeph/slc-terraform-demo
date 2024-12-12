package cloud_function

import (
	"context"
	"log"
	"os"
)

// Entry point for the cloud function
func HandleRequest(ctx context.Context) error {
	log.Println("Cloud function executed successfully.")

	logMsgFromYaml := os.Getenv("LOG_MSG")
	log.Printf("Variable passed in from YAML: %s", logMsgFromYaml)

	return nil
}

