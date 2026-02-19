% for a list write a predicate that creates a list to include the minimum of each sublist
% a. [] -> []
% b. [1, [2,3]] -> [2]
% c. [1,2,3,4] -> []

% minimumSublists(+List, -Result)

% a. base case if we receive an empty list we return an empty list
minimumSublists([],[]).


% findMin(+List,-Min)
findMin([], Min, Min).
findMin([H|T], CurrMin, Min) :-
    H < CurrMin,
    findMin(T, H, Min).
findMin([H|T], CurrMin, Min) :-
    H >= CurrMin,
    findMin(T, CurrMin, Min).

findMin([H|T], Min) :-
    findMin(T, H, Min).

% b. if we find a list we find its minimum and append it in the result list
% c. if there are no lists we dont modify the result list

minimumSublists([H|T],[Min|Rest]):-
    is_list(H),
    findMin(H, Min),
    minimumSublists(T, Rest).

minimumSublists([H|T], Rest):-
    \+ is_list(H),
    minimumSublists(T, Rest).


% Mathematical formula:

% minimumSublists([H|T]) =|  minimum(H) then minimumSublists(T), if H is a list;
                          |  minimumSublists(T), if H is not a list;
                          |  [], if the list is empty

% minimum([H|T], Min) = | Min is H then minimum(T), if H < Min;
                        | minimum(T), if H >= Min.
