% 6.
% a. Write a predicate to test if a list is a set.
% b. Write a predicate to remove the first three occurrences of an element in a list. If the element occurs less 
% than three times, all occurrences will be removed.

% a. Test if a list is a set
testList([]).
testList([H|T]):-
    member(H,T),
    %return false
testList([H|T]):-
    \+ member(H,T),
    testList(T).

% b. Delete 3 occurences of an element

delete3Occ(L, E, R) :- 
    delete_helper(L, E, 3, R).

% 1. Base Case: empty list
delete_helper([], _, _, []).

% 2. If we find the element AND we still need to delete (Occ > 0)
delete_helper([E|T], E, Occ, R) :-
    Occ > 0,
    NewOcc is Occ - 1,
    delete_helper(T, E, NewOcc, R).

% 3. If it's NOT the element OR we finished deleting 3 (Occ = 0)
delete_helper([H|T], E, Occ, [H|R]) :-
    (H \= E ; Occ = 0), % Either it's a different element OR count is hit
    delete_helper(T, E, Occ, R).    
