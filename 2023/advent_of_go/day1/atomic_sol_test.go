package main

import (
	"fmt"
	"testing"
	"time"
)

func TestCheckAtomic(t *testing.T) {
	startTime := time.Now()

	AtomicSolution()

	endTime := time.Now()
	fmt.Println("Atomic solution took: ", endTime.Sub(startTime))
}

