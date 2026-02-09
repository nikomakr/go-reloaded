package main

import (
	"regexp"
	"strconv"
	"strings"
)

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

func isMultiWordModifier(token string) bool {
	matched, _ := regexp.MatchString(`^\([a-z]+,\s*\d+\)$`, token)
	return matched
}

func parseModifier(token string) (string, int) {
	re := regexp.MustCompile(`\(([a-z]+),\s*(\d+)\)`)
	matches := re.FindStringSubmatch(token)

	if len(matches) == 3 {
		modifierType := matches[1]
		count, err := strconv.Atoi(matches[2])
		if err == nil {
			return modifierType, count
		}
	}

	return "", 0
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
