% 7
% a. Determine the position of the maximal element of a linear list.
% Eg.: maxpos([10,14,12,13,14], L) produces L = [2,5].
% b. For a heterogeneous list, formed from integer numbers and list of numbers, replace every sublist with the
% position of the maximum element from that sublist.
% [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

% maxpos(List, Result)

findMax([H|T], Max) :-
    max_list_value(T, H, Max).

findMax([], Max, Max).
findMax([H|T], CurrMax, Max) :-
    H > CurrMax,
    max_list_value(T, H, Max).
findMax([H|T], CurrMax, Max) :-
    H =< CurrMax,
    max_list_value(T, CurrMax, Max).


max_positions(List, Max, Positions) :-
    max_positions(List, Max, 1, Positions).

max_positions([], _, _, []).
max_positions([H|T], Max, Index, [Index|Rest]) :-
    H =:= Max,
    Next is Index + 1,
    max_positions(T, Max, Next, Rest).
max_positions([_|T], Max, Index, Rest) :-
    Next is Index + 1,
    max_positions(T, Max, Next, Rest).


maxpos([],[]).
maxpos(L, Positions) :-
    findMax(L, Max),
    max_positions(L, Max, Positions).
