package main

import (
	"fmt"
	"testing"
	"time"
)

func TestCheckMutex(t *testing.T) {
	startTime := time.Now()

	MutexSolution()

	endTime := time.Now()
	fmt.Println("Mutex solution took: ", endTime.Sub(startTime))
}
