% a. Add an element at the end of a list.
% b. Concatenate two lists.

% a. addElem(List,Elem,Result)

addElem([],X,[X]).
addElem([H|T],X,[H|Rest]):-
    addElem(T, X, Rest).


% b. concat(L1,L2,R).

concat([],L2,L2).
concat(L1, L2, R):-
    concFirstList(L1,L2,R).

concFirstList([],L2,L2):-

concFirstList([H|T], L2, [H|Rest]):-
    concFirstList(T,L2,Rest),

