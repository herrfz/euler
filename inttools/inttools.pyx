from math import log, sqrt


def gcd(a, b):
    '''gcd(a, b): compute greatest common denominator of two integers
        
        a, b: integers
        '''
    while b:
        a, b = b, a % b
    return a


def lcm(a, b):
    '''lcm(a, b): compute least common multiple of two integers
        
        a, b: integers
        '''
    return a * b // gcd(a, b)


def lcmm(*args):
    '''lcmm(a, b, ... ): compute least common multiple of a number of integers
        
        *args: a list of integers
        '''
    return reduce(lcm, args)


def isprime(n):
    '''isprime(n): test if an integer is a prime
        
        n: integer
        '''
    
    if n <= 1:
        return False
    
    # this is more like an exception
    elif n in [2, 3]:
        return True
    
    elif n > 2 and n % 2 == 0:
        return False
    elif n > 3 and ((n + 1) % 6 == 0 or (n - 1) % 6 == 0):
        for i in xrange(2, int(sqrt(n)) + 1):
            if n % i == 0:
                return False
            else:
                continue
    else:
        return False
    
    # if it doesn't fall into any of the 'if' traps, then it's a prime
    return True


def sieve(n):
    '''sieve(n): sieve method to generate prime numbers up to n
        
        n: integer
        return: list of primes
        '''
    A = [0, 0] + [1 for _ in xrange(n-1)]
    
    for i in xrange(2, int(n**.5)):
        if A[i] == 1:
            for j in xrange(i*i, n+1, i):
                A[j] = 0
    
    return [i for i, prime in enumerate(A) if prime]


def sieve2(n):
    '''sieve2(n): sieve method to generate prime numbers up to n
        
        similar to the 'sieve' function, except that a generator is returned 
        instead of a list.
        
        this is more efficient if n is very large, since the primes are 
        generated 'on the fly' instead of being stored in the memory.
        
        if a list of primes is not strictly needed, it is recommended to use
        this method instead of 'sieve'
        '''
    A = [0, 0] + [1 for _ in xrange(n-1)]
    
    for i in xrange(2, n):
        if A[i] == 1:
            if i < int(n**.5):
                for j in xrange(i*i, n+1, i):
                    A[j] = 0
            
            yield i


def nth_prime(n):
    '''nth_prime(n): compute the nth prime number, using the bound from 
        http://mathdl.maa.org/images/cms_upload/jaroma03200545640.pdf
        
        pn <= n * math.log(n) + n * (math.log(math.log(n)) - 0.9385)
        
        and then sieve to get the nth prime
        '''
    
    pn = int( n * log(n) + n * (log(log(n)) - 0.9385) )
    
    return sieve(pn)[n - 1]


def prime_divisors(n):
    '''prime_divisors(n): compute the prime divisors of an integer n
        
        n: integer
        return: list of prime divisors
        '''
    v = int(sqrt(n))
    
    while v > 1:
        if n % v == 0:
            return prime_divisors(v) + ([] if v == 1 else prime_divisors(n/v))
        
        v -= 1
    
    return [n]