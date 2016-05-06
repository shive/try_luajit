# prime_pyx.pyx
from sys import argv
from libc.stdio cimport printf
from libc.math cimport sqrt
from libcpp.vector cimport vector

cdef inline bint isprime(unsigned int n, const unsigned int* primes, size_t primes_len) nogil:
    cdef unsigned int nsqrt = <unsigned int>sqrt(n)
    cdef unsigned int x
    for s in range(primes_len):
        x = primes[s]
        if nsqrt < x: break
        if not(n % x): return False
    return True

cdef inline void main(int capacity) nogil:
    cdef vector[unsigned int] primes
    cdef unsigned int x
    for x in xrange(2, capacity):
        if isprime(x, &primes[0], primes.size()):
            primes.push_back(x)
    printf('%d\n', primes.back())

main(int(argv[1]))

