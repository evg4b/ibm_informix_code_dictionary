package main

import (
	"bufio"
	"encoding/csv"
	"fmt"
	"log"
	"os"
	"regexp"
	"strings"
	"sync"
	// gt "github.com/bas24/googletranslatefree"
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

	rezfile, err := os.Create("database.csv")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	startR := regexp.MustCompile(`^(-?\d+)(\s\(-?\d+\))?\s\w+`)

	scanner := bufio.NewScanner(file)

	writer := csv.NewWriter(rezfile)
	defer writer.Flush()

	writer.Write([]string{
		"id",
		"code",
		"short_description_eng",
		"description_eng",
		"short_description_rus",
		"description_rus",
	})

	var header strings.Builder
	var body strings.Builder
	code := ""
	isHeader := true
	var wg sync.WaitGroup
	i := 1
	for scanner.Scan() {
		line := scanner.Text()
		if len(strings.TrimSpace(line)) == 0 {
			isHeader = false
		}
		items := startR.FindStringSubmatch(line)
		if len(items) > 0 {
			if len(code) > 0 {
				writeFile(writer, i, code, header.String(), body.String())
				i++
			}
			// time.Sleep(time.Second)
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
var re1 = regexp.MustCompile(`^\s*[Ww][Aa][Rr][Nn][Ii][Nn][Gg]\s*(-?\d+)?\s*:`)
var re2 = regexp.MustCompile(`^\s*[Ee][Rr][Rr][Oo][Rr]\s+-?(\d+)?\s*:`)
var delimeter string = "\n##############################################################\n"

func writeFile(writer *csv.Writer, id int, code, header, body string) {
	s := re.ReplaceAllString(header, ``)
	s1 := re1.ReplaceAllString(s, ``)
	s2 := re2.ReplaceAllString(s1, ``)
	s3 := strings.ReplaceAll(s2, "&lt;", "<")
	s4 := strings.ReplaceAll(s3, "&gt;", ">")
	headerEng := strings.TrimSpace(s4)
	headerRus := "RUS"
	// headerRus, _ := gt.Translate(headerEng, "en", "ru")
	bodyEng := strings.TrimSpace(body)
	// bodyRus, _ := gt.Translate(bodyEng, "en", "ru")
	bodyRus := "RUS"
	writer.Write([]string{
		fmt.Sprintf("%d", id),
		code,
		headerEng,
		bodyEng,
		headerRus,
		bodyRus,
	})
	log.Println("Code " + code + " was written")
}
