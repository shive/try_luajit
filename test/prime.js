// prime.js

function isprime(n, primes, primes_len) {
    const nsqrt = Math.sqrt(n);
    for(var Li = 0; Li < primes_len; ++Li) {
        if(nsqrt < primes[Li]) { break; }
        if(n % primes[Li] == 0) { return false; }
    }
    return true;
}

var primes = [];
var primes_len = 0;
var value = process.argv[process.argv.length - 1]
for(var Li = 2; Li < value; ++Li) {
    if(isprime(Li, primes, primes_len)) {
        primes.push(Li);
        primes_len += 1;
    }
}

console.log(primes[primes_len - 1]);

