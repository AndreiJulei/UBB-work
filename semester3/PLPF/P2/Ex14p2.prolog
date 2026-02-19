% 14.
% a. Define a predicate to determine the longest sequences of consecutive even numbers (if exist more maximal
% sequences one of them).
% b. For a heterogeneous list, formed from integer numbers and list of numbers, define a predicate to replace
% every sublist with the longest sequences of even numbers from that sublist.
% Eg.: [1, [2, 1, 4, 6, 7], 5, [1, 2, 3, 4], 2, [1, 4, 6, 8, 3], 2, [1, 5], 3] =>
% [1, [4, 6], 5, [2], 2, [4, 6, 8], 2, [], 3]

% a. longestConsecutive(List,Result)

% check if number is even
is_even(X) :- 0 is X mod 2.

% main predicate
longestConsecutive(L, R) :-
    longestConsecutive_aux(L, [], [], R).

% Case 1: empty input list -> return Best
longestConsecutive_aux([], Curr, Best, BestOut) :-
    (length(Curr, LC), length(Best, LB), LC > LB -> BestOut = Curr ; BestOut = Best).

% Case 2: even number -> extend current sequence
longestConsecutive_aux([H|T], Curr, Best, R) :-
    is_even(H), !,
    append(Curr, [H], Curr1),
    longestConsecutive_aux(T, Curr1, Best, R).

% Case 3: odd number -> close current sequence & compare with best
longestConsecutive_aux([_|T], Curr, Best, R) :-
    (length(Curr, LC), length(Best, LB), LC > LB -> Best1 = Curr ; Best1 = Best),
    longestConsecutive_aux(T, [], Best1, R).



longestConsecutiveHeter([], []).

longestConsecutiveHeter([H|T], [RH|RT]) :-
    is_list(H), !,
    longestConsecutive(H, RH),
    longestConsecutiveHeter(T, RT).

longestConsecutiveHeter([H|T], [H|RT]) :-
    longestConsecutiveHeter(T, RT).