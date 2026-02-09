package main

import "strings"

func fixPunctuation(tokens []string) []string {
	result := []string{}
	punctMarks := ".,!?:;"

	for i := 0; i < len(tokens); i++ {
		word := tokens[i]

		if len(result) == 0 {
			result = append(result, word)
			continue
		}

		leadingPunct := ""
		restOfWord := word

		for len(restOfWord) > 0 && strings.ContainsRune(punctMarks, rune(restOfWord[0])) {
			leadingPunct += string(restOfWord[0])
			restOfWord = restOfWord[1:]
		}

		if leadingPunct != "" {
			lastIdx := len(result) - 1
			result[lastIdx] = result[lastIdx] + leadingPunct

			if restOfWord != "" {
				result = append(result, restOfWord)
			}
		} else {
			result = append(result, word)
		}
	}

	return result
}
