% 9.
% a. For a list of integer number, write a predicate to add in list after 1-st, 3-rd, 7-th, 15-th element a given value e.
% b. For a heterogeneous list, formed from integer numbers and list of numbers; add in every sublist after 1-st,
% 3-rd, 7-th, 15-th element the value found before the sublist in the heterogenous list. The list has the particularity
% that starts with a number and there aren’t two consecutive elements lists.
% Eg.: [1, [2, 3], 7, [4, 1, 4], 3, 6, [7, 5, 1, 3, 9, 8, 2, 7], 5] =>
% [1, [2, 1, 3], 7, [4, 7, 1, 4, 7], 3, 6, [7, 6, 5, 1, 6, 3, 9, 8, 2, 6, 7], 5].


% a. replaceInList(List,E,Result).

% Base case: empty list
replaceInList([], _, _, _, []).

% When CurrentIndex matches CurrentTargetIndex → insert E
replaceInList([H|T], CurrIdx, TargetIdx, E, [H, E | R]) :-
    CurrIdx =:= TargetIdx,
    NextIdx is CurrIdx + 1,
    NextTarget is TargetIdx * 2 + 1,
    replaceInList(T, NextIdx, NextTarget, E, R).

% Otherwise, leave H unchanged
replaceInList([H|T], CurrIdx, TargetIdx, E, [H|R]) :-
    CurrIdx < TargetIdx,
    NextIdx is CurrIdx + 1,
    replaceInList(T, NextIdx, TargetIdx, E, R).

% Wrapper
replaceInList(L, E, R) :-
    replaceInList(L, 1, 1, E, R).



replaceInSublists([], []).

% When current element is a number and next is a list → process it
replaceInSublists([H, Sub | T], [H, NewSub | R]) :-
    number(H),
    is_list(Sub),
    replaceInList(Sub, H, NewSub),
    replaceInSublists(T, R).

% When element is number and next is a number → copy and continue
replaceInSublists([H | T], [H | R]) :-
    number(H),
    replaceInSublists(T, R).
