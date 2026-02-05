package main

import (
	"fmt"
	"os"
	"strconv"
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
	withPunctuation := fixPunctuation(processed)
	withArticles := fixArticles(withPunctuation)
	result := strings.Join(withArticles, " ")
	return result
}

func processTokens(tokens []string) []string {
	result := []string{}

	for i := 0; i < len(tokens); i++ {
		token := tokens[i]

		if isMultiWordModifier(token) {
			modifierType, count := parseModifier(token)
			if modifierType != "" && count > 0 {
				result = applyModifierToMultiple(result, modifierType, count)
			}
			continue
		}

		if token == "(hex)" {
			if len(result) > 0 {
				lastIndex := len(result) - 1
				result[lastIndex] = hexToDec(result[lastIndex])
			}
			continue
		}

		if token == "(bin)" {
			if len(result) > 0 {
				lastIndex := len(result) - 1
				result[lastIndex] = binToDec(result[lastIndex])
			}
			continue
		}

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

func isMultiWordModifier(token string) bool {
	return strings.Contains(token, ",")
}

func parseModifier(token string) (string, int) {
	token = strings.Trim(token, "()")
	parts := strings.Split(token, ",")

	if len(parts) != 2 {
		return "", 0
	}

	modifierType := strings.TrimSpace(parts[0])
	countStr := strings.TrimSpace(parts[1])

	count, err := strconv.Atoi(countStr)
	if err != nil {
		return "", 0
	}

	return modifierType, count
}

func applyModifierToMultiple(result []string, modifierType string, count int) []string {
	start := len(result) - count
	if start < 0 {
		start = 0
	}

	for i := start; i < len(result); i++ {
		switch modifierType {
		case "up":
			result[i] = strings.ToUpper(result[i])
		case "low":
			result[i] = strings.ToLower(result[i])
		case "cap":
			result[i] = capitalize(result[i])
		}
	}

	return result
}

func hexToDec(hex string) string {
	decimal, err := strconv.ParseInt(hex, 16, 64)
	if err != nil {
		return hex
	}
	return strconv.Itoa(int(decimal))
}

func binToDec(bin string) string {
	decimal, err := strconv.ParseInt(bin, 2, 64)
	if err != nil {
		return bin
	}
	return strconv.Itoa(int(decimal))
}

func fixPunctuation(tokens []string) []string {
	result := []string{}
	inQuote := false
	quoteStart := -1

	for i := 0; i < len(tokens); i++ {
		token := tokens[i]

		if token == "'" {
			if !inQuote {
				inQuote = true
				quoteStart = len(result)
			} else {
				inQuote = false
				if quoteStart >= 0 && quoteStart < len(result) {
					result[quoteStart] = "'" + result[quoteStart]
				}
				if len(result) > 0 {
					result[len(result)-1] = result[len(result)-1] + "'"
				}
			}
			continue
		}

		result = append(result, token)
	}

	finalResult := []string{}
	for i := 0; i < len(result); i++ {
		word := result[i]

		cleanWord, prefix, suffix := extractPunctuation(word)

		if cleanWord != "" {
			finalResult = append(finalResult, prefix+cleanWord+suffix)
		} else if suffix != "" {
			if len(finalResult) > 0 {
				finalResult[len(finalResult)-1] = finalResult[len(finalResult)-1] + suffix
			} else {
				finalResult = append(finalResult, suffix)
			}
		}
	}

	return finalResult
}

func extractPunctuation(word string) (string, string, string) {
	prefix := ""
	suffix := ""
	clean := word

	punctuation := ".,!?:;"

	for len(clean) > 0 && strings.ContainsRune(punctuation, rune(clean[len(clean)-1])) {
		suffix = string(clean[len(clean)-1]) + suffix
		clean = clean[:len(clean)-1]
	}

	return clean, prefix, suffix
}

func isPunctuation(r rune) bool {
	return r == '.' || r == ',' || r == '!' || r == '?' || r == ':' || r == ';'
}

func fixArticles(tokens []string) []string {
	result := make([]string, len(tokens))
	copy(result, tokens)

	for i := 0; i < len(result)-1; i++ {
		if strings.ToLower(result[i]) == "a" {
			nextWord := result[i+1]
			cleaned, _, _ := extractPunctuation(nextWord)

			if len(cleaned) > 0 {
				firstChar := strings.ToLower(string(cleaned[0]))
				if firstChar == "a" || firstChar == "e" || firstChar == "i" ||
					firstChar == "o" || firstChar == "u" || firstChar == "h" {
					if result[i] == "a" {
						result[i] = "an"
					} else if result[i] == "A" {
						result[i] = "An"
					}
				}
			}
		}
	}

	return result
}
