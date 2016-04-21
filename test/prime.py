# prime.py
from sys import argv
from math import sqrt

def isprime(n, primes):
    nsqrt = sqrt(n)
    for x in primes:
        if nsqrt < x: break
        if n % x == 0: return False
    return True

primes = []
for x in xrange(2, int(argv[1])):
    if isprime(x, primes): primes.append(x)
print primes[-1]
