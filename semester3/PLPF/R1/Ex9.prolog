% a. Invert a list
% b. Determine the maximum element of a numerical list.

% a. invert(List,Result)

invert([],[]).
invert([H|T],[Rest|H]):-
    invert(T,Rest).

% b. maxElem(List, Maximum)

maxElem([], AuxMax, AuxMax). % when we get to the end of the list we replace the max value in the Maximum variable
maxElem([H|T], H, Maximum):- % case 1: the current elem is > than the current max.
    H > AuxMax,
    maxElem(T, AuxMax, Maximum).
maxElem([H|T],AuxMax, Maximum):-
    H <= AuxMax,
    maxElem(T, AuxMax, Maximum).
