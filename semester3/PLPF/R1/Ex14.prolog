% a. Determine the last element of a list.
% b. Delete elements from a list, from position n to n

% a. lastElem(List,Result)

lastElem([],_).
lastElem([X],X).
lastElem([H|T],R):-
    lastElem(T,R).

% b. delElems(List,Pos1,Pos2,R)

delElems([],_,_,[]).
delElems([], 0, 0, R).

delElems([H|T],Pos1,Pos2,[H|R]):-
    Pos1 > 0,
    NewPos1 is Pos1 -1,
    NewPos2 is Pos2 -1,
    delElems(T,NewPos1,NewPos2,R).

delElems([H|T],0,Pos2,R):-
    Pos2 > 0,
    NewPos2 is Pos2 - 1,
    delElems(T,0,NewPos2,R).

delElems([H|T], 0, 0, [H|R]):-
    delElems(T,R);
