% 1.2. Avoid double recursion. Sol:
f([], -1).
f([H|T], S) :-
    f(T, S1),
    (H > 0, S1 < H -> S is H ; S is S1)

% 1.4. Result = 36

% 2. All Sets of prime numbers that add up to N including N

% Check if P is prime
is_prime(2).
is_prime(3).
is_prime(P) :- 
    P > 3, 
    P mod 2 =\= 0, 
    \+ has_factor(P, 3).

% Helper: Check for factors starting from 3 up to sqrt(P)
has_factor(P, F) :- 
    P mod F =:= 0.
has_factor(P, F) :- 
    F * F < P, 
    F2 is F + 2, 
    has_factor(P, F2).

% Get all primes up to N
primes_up_to(N, Primes) :- 
    findall(P, (between(2, N, P), is_prime(P)), Primes).

% sum_to(TargetSum, ListOfPrimes, ResultingSet)
sum_to(0, _, []).
sum_to(Target, [P|Ps], [P|Rest]) :-
    Target >= P,
    NewTarget is Target - P,
    sum_to(NewTarget, Ps, Rest). % Use Ps (tail) to ensure set property
sum_to(Target, [_|Ps], Rest) :-
    sum_to(Target, Ps, Rest). % Skip the current prime

% solve(N, ResultList)
% flow model (i, o)
solve(N, R) :-
    primes_up_to(N, Primes),
    findall(Set, sum_to(N, Primes, Set), R).

