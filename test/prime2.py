# prime2.py
from __future__ import print_function
from sys import argv
from math import sqrt

def isprime(n, primes):
    nsqrt = sqrt(n)
    for x in primes:
        if nsqrt < x: break
        if not(n % x): return False
    return True

def main():
    capacity = int(argv[1])
    primes = []
    for x in xrange(2, capacity):
        if isprime(x, primes):
            primes.append(x)
    print(int(primes[-1]))

main()

