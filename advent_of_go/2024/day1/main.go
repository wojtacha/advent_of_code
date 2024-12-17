package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	fmt.Println("Hello, World!")

	file, err := os.OpenFile("input.txt")
	if err != nil {
		fmt.Println(err)
	}
	defer file.Close()

	reader := bufio.NewScanner(file)

	for reader.Scan() {
		reader.Text()
	}

}
