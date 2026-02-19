% 10. a. Determine the number formed by adding all even elements and subtracting all odd numbers of the list.
% b. Determine difference of two sets represented as lists

% a. valuesFormed(List,Result)

addEven([], Acc, Acc).
addEven([H|T], Acc, R) :-
    0 is H mod 2,              % even
    NewAcc is Acc + H,
    addEven(T, NewAcc, R).

addEven([H|T], Acc, R) :-
    1 is H mod 2,              % odd → skip
    addEven(T, Acc, R).

subtractOdd([], Acc, Acc).
subtractOdd([H|T], Acc, R) :-
    0 is H mod 2,              % even → skip
    subtractOdd(T, Acc, R).

subtractOdd([H|T], Acc, R) :-
    1 is H mod 2,              % odd → subtract
    NewAcc is Acc - H,
    subtractOdd(T, NewAcc, R).

valuesFormed(L, R) :-
    addEven(L, 0, Temp),
    subtractOdd(L, Temp, R).

% b. diffOfSets(S1,S2,R)
% does the difference of two sets mean the elements from S1 that are not in S2?

diffOfSets([], _, []).

diffOfSets([H|T], S2, R) :-
    member(H, S2),            % H appears in S2 → skip it
    diffOfSets(T, S2, R).

diffOfSets([H|T], S2, [H|R]) :-
    \+ member(H, S2),         % H not in S2 → keep it
    diffOfSets(T, S2, R).