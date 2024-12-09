package cloud_function

import (
	"context"
	"log"
)

// Entry point for the cloud function
func HandleRequest(ctx context.Context) error {
	log.Println("Cloud function executed successfully.")
	return nil
}

func main() {
	// Simulate deployment
	ctx := context.Background()
	if err := HandleRequest(ctx); err != nil {
		log.Fatalf("Error executing cloud function: %v", err)
	}
}