% 3.a. Check if a list is a set (no duplicates)

checkList([]).  % if we reach the end we return true

checkList([H|T]) :- 
    \+ member(H, T),
    checkList(T).


% 3.b. Determine the number of distinct elements in a list

createSet([], []).

createSet([H|T], S) :-
    member(H, T),
    createSet(T, S).

createSet([H|T], [H|S]) :-
    \+ member(H, T),
    createSet(T, S).

distinctElems(L, R) :-
    createSet(L, NewSet),
    length(NewSet, R).
