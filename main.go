package main

import (
	"fmt"
	"os"
)

func main() {
	if len(os.Args) != 3 {
		fmt.Println("Use: go run . <input_file> <output_file>")
		os.Exit(1)
	}
}
