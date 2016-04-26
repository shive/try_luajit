// -*- mode: c++; coding: utf-8-with-signature-dos -*-
//======================================================================================================================

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace prime {
    class Program {
        static bool isprime(int n, List<int> primes) {
            var nsqrt = (int)Math.Sqrt(n);
            foreach(var Li in primes) {
                if(nsqrt < Li) { break; }
                if(n % Li == 0) { return false; }
            }
            return true;
        }
        static void Main(string[] args) {
            var end = int.Parse(args[0]);
            var primes = new List<int>();
            foreach(var Li in Enumerable.Range(2, end - 2)) {
                if(isprime(Li, primes)) {
                    primes.Add(Li);
                }
            }
            Console.WriteLine(primes[primes.Count - 1]);
        }
    }
}

