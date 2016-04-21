﻿# prime.pyx

import sys
from libc.math cimport sqrt
from libc.stdlib cimport malloc, free
from libc.stdio cimport printf

cdef isprime(int n, const int* primes, int primes_len):
    cdef double nsqrt = sqrt(n)
    cdef int Li
    for Li in range(primes_len):
        if nsqrt < primes[Li]: break
        if n % primes[Li] == 0: return 0
    return n

cdef prime(int value):
    cdef int* primes = <int*>malloc(value * sizeof(int))
    cdef int primes_len = 0
    cdef int prime
    for Li in range(2, value):
        prime = isprime(Li, primes, primes_len)
        if prime:
            primes[primes_len] = prime
            primes_len += 1
    print('%d' % primes[primes_len - 1])
    free(primes)

if '__main__' == __name__:
    prime(int(sys.argv[1]))
