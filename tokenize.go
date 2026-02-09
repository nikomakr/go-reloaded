package main

import "regexp"

func smartTokenize(input string) []string {
	re := regexp.MustCompile(`\([a-z]+,\s*\d+\)|\S+`)
	return re.FindAllString(input, -1)
}
