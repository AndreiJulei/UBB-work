% b. For a heterogeneous list, formed from integer numbers and list of numbers, write a predicate to replace 
% every sublist with the position of the maximum element from that sublist.
% [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

replace_sublists([], []).
replace_sublists([H|T], [R|RT]) :-
    is_list(H), !,                   % If H is a list
    max_element(H, Max),             % Find the maximum element
    positions_of_element(H, Max, 1, R), % Find positions of all Max elements
    replace_sublists(T, RT).         % Recurse on the rest

replace_sublists([H|T], [H|RT]) :-   % If H is not a list, keep it
    replace_sublists(T, RT).


max_element([X], X).                 % Base case only one element
max_element([H|T], Max) :-
    max_element(T, MaxTail),         % Find max in the tail
    ( H > MaxTail -> Max = H        % Compare head with max of tail
    ; Max = MaxTail ).


positions_of_element([], _, _, []).  % Base case: empty list -> no positions
positions_of_element([H|T], Elem, Pos, [Pos|Rest]) :-
    H =:= Elem,                      % If current element equals Elem
    NextPos is Pos + 1,
    positions_of_element(T, Elem, NextPos, Rest).
positions_of_element([H|T], Elem, Pos, Rest) :-
    H =\= Elem,                      % If current element not equal Elem
    NextPos is Pos + 1,
    positions_of_element(T, Elem, NextPos, Rest).
