// prime.c
#include <math.h>
#include <stdlib.h>
#include <stdio.h>

int isprime(int n, const int* primes, int primes_len) {
    const double nsqrt = sqrt(n);
    for(int Li = 0; Li < primes_len; ++Li) {
        if(nsqrt < primes[Li]) { break; }
        if(n % primes[Li] == 0) { return 0; }
    }
    return n;
}

int main(int argc, const char** argv) {
    const int primes_capacity = atoi(argv[1]);
    int* const primes = (int*)malloc(primes_capacity * sizeof(int));
    int primes_len = 0;
    int prime;
    for(int Li = 2; Li < primes_capacity; ++Li) {
        if(prime = isprime(Li, primes, primes_len)) {
            primes[primes_len++] = prime;
        }
    }
    printf("%d\n", primes[primes_len - 1]);
    free(primes);
    return 0;
}

