% a. Sort a list with removing the double values. E.g.: [4 2 6 2 3 4] --> [2 3 4 6]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, write a predicate to sort every
% sublist with removing the doubles.
% Eg.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].

% a.manualSort(List,Resutl)

% insertNoDup(Element, List, Result) - insert Element only if not present
insertNoDup(X, [], [X]).
insertNoDup(X, [H|T], [X,H|T]) :- X < H.
insertNoDup(X, [H|T], [H|R]) :-
    X > H,
    insertNoDup(X, T, R).
insertNoDup(X, [H|T], [H|T]) :- X =:= H.   % skip if duplicate

% manualSortNoDup(List, Sorted)
manualSortNoDup([], []).
manualSortNoDup([H|T], Sorted) :-
    manualSortNoDup(T, SortedTail),
    insertNoDup(H, SortedTail, Sorted).

% b. processList(List,Resutl)

processList([], []).

processList([H|T], [RH|RT]) :-
    is_list(H),              % if H is a sublist
    manualSortNoDup(H, RH),             % sort + remove duplicates
    processList(T, RT).

processList([H|T], [H|RT]) :-   % if H is a number
    \+ is_list(H),
    processList(T, RT).
