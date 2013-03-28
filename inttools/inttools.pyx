def gcd(a, b):
    '''compute greatest common denominator of two integers
        
        a, b: integers
        '''
    while b:
        a, b = b, a % b
    return a


def lcm(a, b):
    '''compute least common multiple of two integers
        
        a, b: integers
        '''
    return a * b // gcd(a, b)


def lcmm(*args):
    '''compute least common multiple of a list of integers
        
        *args: a list of integers
        '''
    return reduce(lcm, args)


def isprime(n):
    '''test if an integer is a prime
        
        n: integer
        '''
    import math
    
    if n <= 1:
        return False
    
    # this is more like an exception
    elif n in [2, 3]:
        return True
    
    elif n > 2 and n % 2 == 0:
        return False
    elif n > 3 and ((n + 1) % 6 == 0 or (n - 1) % 6 == 0):
        for i in xrange(2, int(math.sqrt(n)) + 1):
            if n % i == 0:
                return False
            else:
                continue
    else:
        return False
    
    # if it doesn't fall into any of the 'if' traps, then it's a prime
    return True


def sieve(n):
    '''sieve method to generate prime numbers up to n
        
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
    '''sieve method to generate prime numbers up to n
        
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
    '''compute the nth prime number, using the bound from 
        http://mathdl.maa.org/images/cms_upload/jaroma03200545640.pdf
        
        pn <= n * math.log(n) + n * (math.log(math.log(n)) - 0.9385)
        
        and then sieve to get the nth prime
        '''
    from math import log
    
    pn = int( n * log(n) + n * (log(log(n)) - 0.9385) )
    
    return sieve(pn)[n - 1]