% a. Write a predicate to substitute in a list a value with all the elements of another list.
% b. Remove the n-th element of a list.


% a.
substitute([], _, _, []).
substitute([H|T], X, L2, R) :-
    H == X,
    substitute(T, X, L2, R2),
    append(L2, R2, R).

substitute([H|T], X, L2, [H|R]) :-
    H \== X,
    substitute(T, X, L2, R).

% b.
removeNth([], _, []).
removeNth([_|T], 1, T).                % remove first element

removeNth([H|T], N, [H|R]) :-
    N > 1,
    N1 is N - 1,
    removeNth(T, N1, R).
