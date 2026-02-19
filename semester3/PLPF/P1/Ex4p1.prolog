% a. Write a predicate to determine the difference of two sets.
% b. Write a predicate to add value 1 after every even element from a list.

% a. diffOfSets(L1,L2,Result)

























diffDir([], _, []).
diffDir([H|T], L2, R) :-
    member(H, L2),
    diffDir(T, L2, R).
diffDir([H|T], L2, [H|R]) :-
    \+ member(H, L2),
    diffDir(T, L2, R).


diffOfSets(L1, L2, Result) :-
    diffDir(L1, L2, R1),
    diffDir(L2, L1, R2),
    append(R1, R2, Result).


% b. addOne(List,Result)

addOne([], []).

addOne([H|T], [H|R]) :-
    1 is H mod 2,        % odd
    addOne(T, R).

addOne([H|T], [H,1|R]) :-
    0 is H mod 2,        % even
    addOne(T, R).
