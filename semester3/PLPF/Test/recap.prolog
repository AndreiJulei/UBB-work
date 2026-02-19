% 2. permutations with abs diff <= 3

% Standard insertion into all possible positions
insert(E, L, [E|L]).
insert(E, [H|T], [H|R]) :-
    insert(E, T, R).

% Generates permutations
permutations([], []).
permutations(P, [H|T]) :-
    permutations(R, T), % Recurse on the tail first
    insert(H, R, P).    % Insert the head into the result

% Checks adjacent absolute difference
absDiff([_]). % Base case: single element is valid
absDiff([H1, H2|T]) :-
    Diff is abs(H1 - H2),
    Diff =< 3,        % Correct comparison operator
    absDiff([H2|T]).  % Corrected list syntax

% Main predicate
solve(L, R) :-
    findall(P, (permutations(P, L), absDiff(P)), R).

(format "Permutations with abs diff <= 3 are: ~a~%" (solve '(2 5 7)))
