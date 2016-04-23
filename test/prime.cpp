// prime.cpp
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <vector>

int isprime(int n, const std::vector<int>& primes) {
    const double nsqrt = sqrt(n);
    for(const auto& curs : primes) {
        if(nsqrt < curs) { break; }
        if(n % curs == 0) { return 0; }
    }
    return n;
}

int main(int argc, const char** argv) {
    const int primes_capacity = atoi(argv[1]);
    std::vector<int> primes;
    primes.reserve(primes_capacity);
    for(int Li = 2; Li < primes_capacity; ++Li) {
        if(int prime = isprime(Li, primes)) {
            primes.push_back(prime);
        }
    }
    printf("%d\n", primes.back());
    return 0;
}

