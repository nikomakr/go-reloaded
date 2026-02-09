package main

import "strings"

func fixArticles(tokens []string) []string {
	result := make([]string, len(tokens))
	copy(result, tokens)

	for i := 0; i < len(result)-1; i++ {
		currentWord := result[i]
		nextWord := result[i+1]

		if strings.ToLower(currentWord) == "a" {
			cleanNext := strings.TrimLeft(nextWord, ".,!?:;'\"")

			if len(cleanNext) > 0 {
				firstChar := strings.ToLower(string(cleanNext[0]))
				if firstChar == "a" || firstChar == "e" || firstChar == "i" ||
					firstChar == "o" || firstChar == "u" || firstChar == "h" {
					if currentWord == "a" {
						result[i] = "an"
					} else if currentWord == "A" {
						result[i] = "An"
					}
				}
			}
		}
	}

	return result
}
