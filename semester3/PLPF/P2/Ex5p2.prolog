% 5.
% a. Substitute all occurrences of an element of a list with all the elements of another list.
% Eg. subst([1,2,1,3,1,4],1,[10,11],X) produces X=[10,11,2,10,11,3,10,11,4].
% b. For a heterogeneous list, formed from integer numbers and list of numbers, replace in every sublist all
% occurrences of the first element from sublist it a new given list.
% Eg.: [1, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] si [11, 11] =>
% [1, [11, 11, 1, 11, 11], 3, 6, [11, 11, 10, 1, 3, 9], 5, [11 11 11 11 11 11], 7]


% Base case: empty list
subst([], _, _, []).

% If head matches the element, replace it with the list
subst([E|T], E, L, Result) :-
    subst(T, E, L, Rest),
    append(L, Rest, Result).

% If head does not match, keep it
subst([H|T], E, L, [H|Rest]) :-
    H \= E,
    subst(T, E, L, Rest).




% Base case: empty list
substSublists([], _, []).

% If head is a list, replace occurrences of first element
substSublists([H|T], L, [NewH|NewT]) :-
    is_list(H),
    H = [First|_],
    subst(H, First, L, NewH),
    substSublists(T, L, NewT).

% If head is not a list, keep it
substSublists([H|T], L, [H|NewT]) :-
    \+ is_list(H),
    substSublists(T, L, NewT).
