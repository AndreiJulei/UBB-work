% 1.2. Avoid double recursion
f([],-1).
f([H|T], S) :-
    f(T, S1),
    S1 > 0, !,
    S is S1 +H.
f([_|T], S):-
    f(T,S1),
    S is S1.

% Solution
f([],-1).
f([H|T], S):-
    f(T, S1),
    (S1 > 0 -> S is S1 + H ; S is S1).

% 1.4. Funciton g is adding in L all even numbers from the list [1,2,3]
% so the result is [2].

% 2. Permutations of Elemets N, N + 1, ..., 2*N-1. Where the
% absolute difference between elements is <= 2.

% Check the absolute difference of the generated permutation
check([]).
check([H1,H2|T]):-
    Dif is Abs (H1 - H2),
    Dif >= 2,
    check([H2|T]).
    
% Generate Elements N, N+1, ..., 2*N-1. Flow model(o,i)
generateList([],0).
generateList([N1|T], N, Limit):-
    N <= Limit,
    generateList(T, N1),
    N1 is N + 1.

% Main module -- flow model (i, o)
solve(N,Res):-
    Lim is 2 * N - 1,
    genereateNList(L,N,Lim),
    findall(P, (permutaitons(L,P), check(P)), Res).