% a. Merge two sorted lists with removing the double values.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, merge all sublists with removing
% the double values.
% [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8] =>
% [1, 2, 3, 4, 6, 7, 9, 10, 11].

% mergeNoDup(L1, L2, Result) - merge two sorted lists, removing duplicates
mergeNoDup([], L, L).
mergeNoDup(L, [], L).
mergeNoDup([H1|T1], [H2|T2], [H1|R]) :-
    H1 < H2,
    mergeNoDup(T1, [H2|T2], R).
mergeNoDup([H1|T1], [H2|T2], [H2|R]) :-
    H1 > H2,
    mergeNoDup([H1|T1], T2, R).
mergeNoDup([H|T1], [H|T2], [H|R]) :-  % skip duplicates
    mergeNoDup(T1, T2, R).



% flattenHetero(List, FlatList) - flatten integers and sublists

% myAppend(List1, List2, Result) - concatenates List1 and List2 into Result
myAppend([], L, L).
myAppend([H|T], L2, [H|R]) :-
    myAppend(T, L2, R).

flattenHetero([], []).
flattenHetero([H|T], Flat) :-
    is_list(H),
    flattenHetero(H, FlatH),
    flattenHetero(T, FlatT),
    myAppend(FlatH, FlatT, Flat).
flattenHetero([H|T], [H|FlatT]) :-
    \+ is_list(H),
    flattenHetero(T, FlatT).

% sortAndMergeNoDup(List, SortedNoDup)
sortAndMergeNoDup(L, R) :-
    flattenHetero(L, Flat),
    manualSortNoDup(Flat, R).   % use manualSortNoDup from previous implementation