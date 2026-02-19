% 2. a. Substitute the i-th element from a list with a value V.
% substitute(List, Pos, Value, Result)

substitute([], _, _, []).    % if the list is empty, result is empty

substitute([_|T], 1, V, [V|T]) :- !.    % when position = 1, replace head with V

substitute([H|T], Pos, V, [H|R]) :-
    Pos > 1,                       % if position is after the head
    NextPos is Pos - 1,            % decrement position
    substitute(T, NextPos, V, R).  % recurse on the tail


% 2. b. Determine the difference of two sets represented as lists.
% difference(L1, L2, Result)

difference([], _, []).    % if first list empty, difference is empty

difference([H|T], L2, R) :-
    member(H, L2),        % if element H is in L2, skip it
    difference(T, L2, R).

difference([H|T], L2, [H|R]) :-
    \+ member(H, L2),     % if element H is NOT in L2, keep it
    difference(T, L2, R).
