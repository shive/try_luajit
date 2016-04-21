// prime.js

function isprime(n, primes) {
    const nsqrt = Math.sqrt(n);
    for(var Li = 0; Li < primes.length; ++Li) {
        if(nsqrt < primes[Li]) { break; }
        if(n % primes[Li] == 0) { return false; }
    }
    return true;
}

var primes = [];
for(var Li = 2; Li < process.argv[process.argv.length - 1]; ++Li) {
    if(isprime(Li, primes)) {
        primes.push(Li)
    }
}

console.log(primes[primes.length - 1]);

