% 5. a. Determine the greatest common divisors of elements from a list.
% b. Insert an element on the n-position in a list.

% cmmdcList(List,Result)

% gcd of two numbers
gcd(X, 0, X) :- !.
gcd(X, Y, R) :-
    Y > 0,
    Rem is X mod Y,
    gcd(Y, Rem, R).

% gcd of a list
cmmdcList([X], X).
cmmdcList([H|T], R) :-
    cmmdcList(T, R2),
    gcd(H, R2, R).

% b. insert(L1,Pos,E,R)

insert([], _, _, []).

insert([H|T], Pos, E, [H|R]) :-     % copy head until position is reached
    Pos > 0,
    NewPos is Pos - 1,
    insert(T, NewPos, E, R).

insert(L, 0, E, [E|L]).             % when pos is 0, insert before L
