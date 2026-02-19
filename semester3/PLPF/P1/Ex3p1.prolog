% a. Define a predicate to remove from a list all repetitive elements.
% Eg.: l=[1,2,1,4,1,3,4] => l=[2,3]
% b. Remove all occurrence of a maximum value from a list on integer numbers.

% a. remRep(List,Result)

remRep([],[]).
remRep([H|T],R):-
    member(H,T),
    remRep(T,R).

remRep([H|T],[H|R]):-
    \+ member(H,T),
    remRep(T,R).

% b. remMax(List,Result).

getMax([H|T], Max) :-
    getMax(T, H, Max).

getMax([], Max, Max).
getMax([H|T], Current, Max) :-
    H > Current,
    getMax(T, H, Max).
getMax([H|T], Current, Max) :-
    H =< Current,
    getMax(T, Current, Max).

rmMx([], _, []).
rmMx([H|T], Max, R) :-
    H == Max,
    rmMx(T, Max, R).
rmMx([H|T], Max, [H|R]) :-
    H \== Max,
    rmMx(T, Max, R).

remMax(L, R) :-
    getMax(L, Max),
    rmMx(L, Max, R).
