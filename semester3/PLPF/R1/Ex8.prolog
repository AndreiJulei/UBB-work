% a. Determine the lowest common multiple of the elements from a list.
% b. Substitute in a list, all occurrence of a value e with a value e1.

% b. substituteElem(List,E,E1,Result)

substituteElem([],_,_,[]).

substituteElem([H|T],E,E1,[H|R]):-      % case 1: element is not the substitute elem
    H \= E,
    substituteElem(T,E,E1,R).

substituteElem([H|T],E,E1,[E1|R]):-     % case 2: element is the substitute elem
    H = E,
    substituteElem(T,E,E1,R).

% a.

lcm(X, Y, R) :-
    gcd(X, Y, G),
    R is X * Y // G.

lcmList([X], X).
lcmList([H|T], R) :-
    lcmList(T, R2),
    lcm(H, R2, R).


