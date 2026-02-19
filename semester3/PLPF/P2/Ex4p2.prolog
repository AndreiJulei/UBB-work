% 4.
% a. Write a predicate to determine the sum of two numbers written in list representation.
% b. For a heterogeneous list, formed from integer numbers and list of digits, write a predicate to compute the
% sum of all numbers represented as sublists.
% Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => [8, 2, 2].


% a. sumOfLists(L1,L2,R)

createNumber([], Acc, Acc).
createNumber([H|T], Acc, Number) :-
    NewAcc is Acc * 10 + H,
    createNumber(T, NewAcc, Number).

sumOfLists(L1, L2, R) :-
    createNumber(L1, 0, N1),
    createNumber(L2, 0, N2),
    R is N1 + N2.

% b. sumOfSublists(List,Result)

numberToList(0, [0]).
numberToList(Number, Digits) :-
    Number > 0,
    numberToListHelper(Number, RevDigits),
    reverse(RevDigits, Digits).

numberToListHelper(0, []).
numberToListHelper(Number, [D|T]) :-
    Number > 0,
    D is Number mod 10,
    N1 is Number // 10,
    numberToListHelper(N1, T).


sumOfSublists(List, Result) :-
    sumSublistsHelper(List, 0, Sum),
    numberToList(Sum, Result).

sumSublistsHelper([], Acc, Acc).
sumSublistsHelper([H|T], Acc, Sum) :-
    is_list(H),
    createNumber(H, 0, N),
    NewAcc is Acc + N,
    sumSublistsHelper(T, NewAcc, Sum).
sumSublistsHelper([H|T], Acc, Sum) :-
    \+ is_list(H),  % ignore integers
    sumSublistsHelper(T, Acc, Sum).
