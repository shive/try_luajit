// prime.java

import java.util.*;

class prime {
    public static boolean isprime(int n, List<Integer> primes) {
        int nsqrt = (int)Math.sqrt(n);
        for(int Li : primes) {
            if(nsqrt < Li) { break; }
            if(n % Li == 0) { return false; }
        }
        return true;
    }
    public static void main(String args[]) {
        int end = Integer.parseInt(args[0]);
        List<Integer> primes = new ArrayList<Integer>();
        for(int Li = 2; Li < end; ++Li) {
            if(isprime(Li, primes)) {
                primes.add(Li);
            }
        }
        System.out.println(primes.get(primes.size() - 1));
    }
}
