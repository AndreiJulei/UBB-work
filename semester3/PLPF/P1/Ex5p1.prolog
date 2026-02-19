% a. Write a predicate to compute the union of two sets.
% b. Write a predicate to determine the set of all the pairs of elements in a list.
% Eg.: L = [a b c d] => [[a b] [a c] [a d] [b c] [b d] [c d]].

% a. union(S1,S2,R)

union([], S, S).
union([H|T], S2, R) :-
    member(H, S2),
    union(T, S2, R).

union([H|T], S2, [H|R]) :-
    \+ member(H, S2),
    union(T, S2, R).


% b. getPairs(List,Result):-

pairsWith(_, [], []).
pairsWith(X, [H|T], [[X,H] | R]) :-
    pairsWith(X, T, R).

getPairs([], []).
getPairs([_], []).              
getPairs([H|T], R) :-
    pairsWith(H, T, R1),
    getPairs(T, R2),
    append(R1, R2, R).

