-- prime.lua
function isprime(n, primes, primes_len)
    local nsqrt = n ^ 0.5
    for i = 1, primes_len do
        if nsqrt < primes[i] then break end
        if n % primes[i] == 0 then return false end
    end
    return true
end

local primes = {}
local primes_len = 0
for i = 2, arg[1] * 1 do
    if isprime(i, primes, primes_len) then
        primes_len = primes_len + 1
        primes[primes_len] = i
    end
end

print(primes[primes_len])
