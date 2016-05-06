# prime3.py
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
    for x in map(float, range(2, capacity)):
        if isprime(x, primes):
            primes.append(x)
    print(int(primes[-1]))

main()

