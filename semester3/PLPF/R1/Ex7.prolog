% a. Test the equality of two lists.
% b. Determine the intersection of two sets represented as lists

% a. testEq(L1,L2) -> true


testEq([],[]).
testEq([H|T],[H2,T2]):-
    H = H2,
    testEq(T,T2).

checkElem(_, []) :- fail.
checkElem(X, [H|T]) :-
    X \= H,
    checkElem(X, T).
checkElem(X, [H|_]) :-
    X = H.

% intersection(L1,L2,R)

intersection([], _, []).             %base case
intersection([H|T],L2,[H|Rest]):-   % case 1: if the element is in both lists then we add it to the result list
    member(H,L2),
    intersection(T,L2,Rest).

intersection([H|T],L2,R):-          % case 2: if the element is only in one list we move to the next element
    intersection(T,L2,R).

    