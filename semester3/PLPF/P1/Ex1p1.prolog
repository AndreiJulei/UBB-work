% a. Write a predicate to determine the lowest common multiple of a list formed from integer numbers.
% b. Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … element in a list.

% a. lcmOfList(List,R)

gcd(X, 0, X) :- !.
gcd(X, Y, R) :-
    Rem is X mod Y,
    gcd(Y, Rem, R).

lcm(X, Y, R) :-
    gcd(X, Y, G),
    R is X * Y // G.

lcmOfList([X], X).
lcmOfList([H|T], R) :-
    lcmOfList(T, R2),
    lcm(H, R2, R).


% b. addElemToPwr(List,Value,Result)

addElemToPwr(List, V, Result) :-
    addElemToPwr(List, V, 1, 1, Result).

% If current position matches next power-of-two, insert V.
addElemToPwr([H|T], V, Pos, NextPow, [H, V | R]) :-
    Pos =:= NextPow,
    NextPow2 is NextPow * 2,
    Pos2 is Pos + 1,
    addElemToPwr(T, V, Pos2, NextPow2, R).

% Otherwise, just pass the element through.
addElemToPwr([H|T], V, Pos, NextPow, [H | R]) :-
    Pos =\= NextPow,
    Pos2 is Pos + 1,
    addElemToPwr(T, V, Pos2, NextPow, R).

% End of list
addElemToPwr([], _, _, _, []).
