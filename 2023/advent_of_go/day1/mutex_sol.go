package main

import (
	"fmt"
	"os"
	"sync"
)

type Counter struct {
	mu      sync.Mutex
	counter int
}

func (c *Counter) decrement() {
	c.mu.Lock()
	c.counter--
	c.mu.Unlock()
}

func (c *Counter) increment() {
	c.mu.Lock()
	c.counter++
	c.mu.Unlock()
}

func f(wg *sync.WaitGroup, count *Counter, sign string) {
	if sign == "(" {
		count.increment()
	}

	if sign == ")" {
		count.decrement()
	}

	wg.Done()
}

func MutexSolution() {
	b, err := os.ReadFile("./main.2")
	if err != nil {
		fmt.Println(err)
		panic(err)
	}

	floorCipher := string(b)

	var wg sync.WaitGroup
	count := Counter{counter: 0}

	for i := 0; i < len(floorCipher); i++ {
		wg.Add(1)
		go f(&wg, &count, string(floorCipher[i]))
	}

	wg.Wait()

	fmt.Println(count.counter)
}
