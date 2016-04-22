﻿# prime.py
from sys import argv
from math import sqrt
from array import array

def isprime(n, primes):
    nsqrt = sqrt(n)
    for x in primes:
        if nsqrt < x: break
        if n % x == 0.0: return False
    return True

def main():
    capacity = int(argv[1])
    primes = array('f')
    for x in (float(s) for s in range(2, capacity)):
        if isprime(x, primes):
            primes.append(x)
    print(int(primes[-1]))

main()

