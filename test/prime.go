// prime.go

package main

import (
    "fmt"
    "os"
    "strconv"
    "math"
)

func isprime(n int, primes []int) bool {
    nsqrt := int(math.Sqrt(float64(n)))
    for _, Li := range primes {
        if nsqrt < Li { break; }
        if n % Li == 0 { return false; }
    }
    return true;
}

func main() {
    end, _ := strconv.Atoi(os.Args[1])
    var primes []int
    for Li := 2; Li < end; Li++ {
        if isprime(Li, primes) {
            primes = append(primes, Li);
        }
    }
    fmt.Printf("%d\n", primes[len(primes) - 1])
}
