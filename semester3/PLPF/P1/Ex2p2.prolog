% a. Write a predicate to remove all occurrences of a certain atom from a list.
% b. Define a predicate to produce a list of pairs (atom n) from an initial list of atoms. In this initial list atom has
% n occurrences.
% Eg.: numberatom([1, 2, 1, 2, 1, 3, 1], X) => X = [[1, 4], [2, 2], [3, 1]].

removeAll(_, [], []).
removeAll(A, [A|T], R) :-
    removeAll(A, T, R).               % skip occurrences
removeAll(A, [H|T], [H|R]) :-
    A \== H,
    removeAll(A, T, R).               % keep other elements


% b. 