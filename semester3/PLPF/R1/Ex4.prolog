% 4. a. Determine if a list has even number of elements, without computing the length of the list.
% b. Delete all occurrences of an element e from a list.

% evenList(List)

evenList([]).

evenList([_]) :- !,fail. % if only one element is remaining -> false

evenList([_, _|T]) :-
    evenList(T).      % remove two elements at once 


% deleteOcc(List,Element,Result)

deleteOcc([],_,[]).

deleteOcc([X|T], X, R):-
    deleteOcc(T,X,R).

deleteOcc([H|T], X, [H|R]):-
    H \= X,
    deleteOcc(T, X, R).