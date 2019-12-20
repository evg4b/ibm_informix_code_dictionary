package main

import (
	"bufio"
	"io/ioutil"
	"log"
	"os"
	"regexp"
	"strings"
	"sync"
)

type item struct {
	Code         string
	EngShortDesc string
	RusShortDesc string
	EngDesc      string
	RusDesc      string
}

func main() {
	file, err := os.Open("src/source.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	startR := regexp.MustCompile(`^(-?\d+)(\s\(-?\d+\))?\s\w+`)

	scanner := bufio.NewScanner(file)
	var header strings.Builder
	var body strings.Builder
	code := ""
	isHeader := false
	var wg sync.WaitGroup
	for scanner.Scan() {
		line := scanner.Text()
		if len(strings.TrimSpace(line)) == 0 {
			isHeader = false
		}
		items := startR.FindStringSubmatch(line)
		if len(items) > 0 {
			wg.Add(1)
			go writeFile(&wg, code, header.String(), body.String())
			header.Reset()
			body.Reset()
			code = items[1]
			isHeader = true
		}
		if isHeader {
			header.WriteString(line)
		} else {
			body.WriteString(line + "\n")
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
	wg.Wait()
}

var re = regexp.MustCompile(`^(-?\d+)(\s\(-?\d+\))?`)
var re1 = regexp.MustCompile(`^\s*[Ww][Aa][Rr][Nn][Ii][Nn][Gg]\s+-?\d+\s*:`)
var re2 = regexp.MustCompile(`^\s*[Ee][Rr][Rr][Oo][Rr]\s+-?\d+\s*:`)

func writeFile(wg *sync.WaitGroup, code, header, body string) {
	s := re.ReplaceAllString(header, ``)
	s1 := re1.ReplaceAllString(s, ``)
	s2 := re1.ReplaceAllString(s1, ``)

	d1 := []byte(code + "\n\n" + strings.TrimSpace(s2) + "\n\n" + strings.TrimSpace(body))
	ioutil.WriteFile("data/"+code+".txt", d1, 0644)
	wg.Done()
}
