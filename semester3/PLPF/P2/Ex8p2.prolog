% 8.
% a. Determine the successor of a number represented as digits in a list.
% Eg.: [1 9 3 5 9 9] --> [1 9 3 6 0 0]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, determine the successor of a
% sublist considered as a number.
% [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] =>
% [1, [2, 4], 4, 5, [6, 8, 0], 10, 11, [1, 2, 1], 6]


% a. findSuccessor(List,Result)

listToNumber([],Acc,Acc).
listToNumber([H|T],Acc,N):-
    NewAcc is Acc * 10 + H,
    listToNumber(T,NewAcc,N).

numberToList(0,[]).
numberToList(N,[LastDigit|RestHead]):-
    N > 0,
    LastDigit is N mod 10,
    N1 is N // 10,
    numberToList(N1,RestHead).

findSuccessor([],[]).
findSuccessor(L,R):-
    listToNumber(L,0,N),
    NewNumber is N + 1,
    numberToList(NewNumber,R).


% b. findSuccessorList(List,Result)

findSuccessorList([],[]).
findSuccessorList([H|T],[CurrentSuccessor|Rest]):-
    is_list(H),
    findSuccessor(H,CurrentSuccessor),
    findSuccessorList(T,Rest).

findSuccessorList([H|T],[H|Rest]):-
    \+ is_list(H),
    findSuccessorList(T,Rest).