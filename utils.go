package main

import (
	"strconv"
	"strings"
)

func capitalize(word string) string {
	if len(word) == 0 {
		return word
	}
	return strings.ToUpper(string(word[0])) + strings.ToLower(word[1:])
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
