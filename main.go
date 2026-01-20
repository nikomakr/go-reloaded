package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	if len(os.Args) != 3 {
		fmt.Println("Use: go run . <input_file> <output_file>")
		os.Exit(1)
	}

	inputFile := os.Args[1]
	outputFile := os.Args[2]

	content, err := readFile(inputFile)
	if err != nil {
		fmt.Printf("Error reading file '%s' : %v\n", inputFile, err)
		os.Exit(1)
	}

	result := processText(content)

	err = writeFile(outputFile, result)
	if err != nil {
		fmt.Printf("Error writing file '%s' : %v\n", outputFile, err)
		os.Exit(1)
	}

	fmt.Printf("File processed successfully!")
}

func readFile(filename string) (string, error) {
	bytes, err := os.ReadFile(filename)
	if err != nil {
		return "", err
	}
	return string(bytes), nil
}

func writeFile(filename string, content string) error {
	return os.WriteFile(filename, []byte(content), 0644)
}

func processText(input string) string {
	tokens := strings.Fields(input)
	processed := processTokens(tokens)
	result := strings.Join(processed, " ")
	return result
}

func processTokens(tokens []string) []string {
	result := []string{}
	
	for i := 0; i < len(tokens); i++ {
		token := tokens[i]
		
		if token == "(up)" {
			if len(result) > 0 {
				lastIndex := len(result) - 1
				result[lastIndex] = strings.ToUpper(result[lastIndex])
			}
			continue
		}
		
		if token == "(low)" {
			if len(result) > 0 {
				lastIndex := len(result) - 1
				result[lastIndex] = strings.ToLower(result[lastIndex])
			}
			continue
		}
		
		if token == "(cap)" {
			if len(result) > 0 {
				lastIndex := len(result) - 1
				result[lastIndex] = capitalize(result[lastIndex])
			}
			continue
		}
		
		result = append(result, token)
	}
	
	return result
}

func capitalize(word string) string {
	if len(word) == 0 {
		return word
	}
	return strings.ToUpper(string(word[0])) + strings.ToLower(word[1:])
}