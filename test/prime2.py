# prime.py
from __future__ import print_function
from sys import argv
from math import sqrt

def isprime(n, primes):
    nsqrt = sqrt(n)
    for x in primes:
        if nsqrt < x: break
        if n % x == 0: return False
    return True

def main():
    capacity = int(argv[1])
    primes = []
    for x in range(2, capacity):
        if isprime(x, primes):
            primes.append(x)
    print(primes[-1])

main()

