% 15.a. Substitute all occurrences of an element from a list with another list.
% b. Determine the element from the n-th position in a list

% a. substituteWithList(L1,E,L2,R)

substituteWithList([],E,L2,R).
substituteWithList([H|T],E,L2,[H|R]):-
    H \= E,
    substituteWithList(T,E,L2,R).
    
substituteWithList([H|T],E,L2,L2):-
    H = E,
    substituteWithList(T,E,L2,R).

% b. elemOnPosN(List,PosN,Result)

elemOnPosN([H|T], 0, H).
elemOnPosN([H|T],P,R):-
    P > 0,
    NewPos is P - 1,
    elemOnPosN(T,NewPos,R).