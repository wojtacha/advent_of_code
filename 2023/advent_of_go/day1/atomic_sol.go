package main

import (
	"fmt"
	"os"
	"sync"
	"sync/atomic"
)

func g(wg *sync.WaitGroup,counter  *int32,  sign string) {
	if sign == "(" {
		atomic.AddInt32(counter, 1)
	}

	if sign == ")" {
		atomic.AddInt32(counter, -1)
	}

	wg.Done()
}

func AtomicSolution() {
	var counter int32

	b, err := os.ReadFile("./main.2")
	if err != nil {
		fmt.Println(err)
		panic(err)
	}

	floorCipher := string(b)

	var wg sync.WaitGroup

	for i := 0; i < len(floorCipher); i++ {
		wg.Add(1)
		go g(&wg, &counter, string(floorCipher[i]))
	}

	wg.Wait()
	fmt.Println(counter)

}
