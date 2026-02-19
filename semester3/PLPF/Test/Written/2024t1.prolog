% 1.2 Avoid the double recursion call f(j,v), flow model(i,o)

f(0, 0) :- !.
f(I, Y) :- 
    J is I - 1
    f(J,V),
    V > 1, !,
    K is I - 2,
    Y is K.
f(I, Y) :-
    J is I - 1,
    f(J,V),
    Y is V + 1.

% Solution:
f(0,0) :- !.
f(I,Y) :-
    J is I - 1,
    f(J, V),
    (V > 1 -> K is I - 2, Y is K ; Y is V + 1).


% 1.4. Solution: The effect of p(0) is an infinite recursion
% because the function p only stops when the number reaches 100.
% If we start from 0 and keep subtracting it will keep decrementing.

% 2. All arrangements of 5 chairs where at most 5 chairs are 
% yellow and the rest are red

% Place the maximum number of possibilities in an vector and 
% create arrangements with that vector.
% Flow model (o):
fillMaxPos([Y, Y, Y, R, R, R, R, R]):

% Flow model (i,o):

placeChairs([H|_], 1, [H]).     % base case: pick one elem
placeChairs([_|T], K, R).       % skip the head
placeChairs([H|T], K, [H|Rest]):-
    K1 is K-1,
    placeChairs(T, K1, Rest).

% Main module
% flow model (o)
solve(S):-
    fillMaxPos(MaxPos),
    findall(Arr, 
    (arrangements(MaxPos, 5, Arr)) S).



% check(List, YellowCount)
check([], Y) :- Y =< 3.
check([h|t], Y) :- h = 'Y', Y1 is Y + 1, Y1 =< 3, check(t, Y1).
check([h|t], Y) :- h = 'R', check(t, Y).

% generate(Length, CurrentList)
generate(0, []).
generate(N, [H|T]) :- N > 0, N1 is N - 1, (H = 'R' ; H = 'Y'), generate(N1, T).

solve2(R) :- findall(L, (generate(5, L), check(L, 0)), R).