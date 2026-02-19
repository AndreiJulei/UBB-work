% 7.
% a. Write a predicate to compute the intersection of two sets.
% b. Write a predicate to create a list (m, ..., n) of all integer numbers from the interval [m, n]

% a. Intersection of two sets
% If the first list is empty, the intersection is empty.
intersection([], _, []).

% If H is in S2, include it in the result.
intersection([H|T], S2, [H|Rest]) :-
    member(H, S2),
    intersection(T, S2, Rest).

% If H is NOT in S2, skip it.
intersection([H|T], S2, Rest) :-
    \+ member(H, S2),
    intersection(T, S2, Rest).


% b. Create a list From M to N
range(M, N, []) :- 
    M > N.

range(M, N, [M|Rest]) :-
    M =< N,
    NextM is M + 1,
    range(NextM, N, Rest).