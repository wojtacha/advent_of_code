package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	// Open the file test.txt
	file, err := os.Open("test.txt")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	var result [][]int

	// Create a scanner to read the file line by line
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		// Split the line into fields
		fields := strings.Fields(line)
		var nums []int
		for _, field := range fields {
			num, err := strconv.Atoi(field)
			if err != nil {
				fmt.Println("Error parsing number:", err)
				return
			}
			nums = append(nums, num)
		}
		result = append(result, nums)
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading file:", err)
		return
	}

	var sum = 0

	for i := 0; i < len(result); i++ {
		if result[i][0] < result[i][1] {
			sum = sum + ascending(result[i])
		} else {
			sum = sum + descending(result[i])
		}
	}
	print(sum)
}

func ascending(list []int) int {
	for i := 1; i < len(list); i++ {
		var diff = list[i] - list[i-1]
		if diff <= 0 {
			return 0
		}
		if diff >= 4 {
			return 0
		}
	}
	return 1
}

func descending(list []int) int {
	for i := 1; i < len(list); i++ {
		var diff = list[i-1] - list[i]
		if diff <= 0 {
			return 0
		}
		if diff >= 4 {
			return 0
		}
	}

	return 1
}
