package main

import "strings"

func fixQuotes(tokens []string) []string {
	result := []string{}
	inQuote := false
	quoteBuffer := []string{}

	for _, token := range tokens {
		if token == "'" {
			if !inQuote {
				inQuote = true
				quoteBuffer = []string{}
			} else {
				if len(quoteBuffer) > 0 {
					quoted := "'" + strings.Join(quoteBuffer, " ") + "'"
					result = append(result, quoted)
				}
				inQuote = false
				quoteBuffer = []string{}
			}
		} else {
			if inQuote {
				quoteBuffer = append(quoteBuffer, token)
			} else {
				result = append(result, token)
			}
		}
	}

	return result
}
