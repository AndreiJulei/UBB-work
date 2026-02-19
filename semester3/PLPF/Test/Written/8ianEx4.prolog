
% 1.2 Avoid double recursion for (i,o):

f(1,1):-!.
f(K,X):-
    K1 is K - 1,
    f(K1, Y),
    Y > 1,
    K2 is K1 - 1,
    X is K2.
f(K,X):-
    K1 is K-1,
    f(K1,Y),
    Y > 0.5,
    X is Y.
f(K,X) :-
    K1 is K-1
    f(K1,Y),
    X is Y-1.

% Solution:

f(1,1) :- !.

f(K,X) :- 
    K1 is K-1,
    f(K1,Y),
    (Y > 1 -> K2 is K1-1, X is K2 ; 
    Y > 0.5 -> X is Y ; 
    X is Y - 1).

% 1.4 Sol: "1, 1, 1, 2" / 1, 2, 1, 1

% 2. All arrangements with the product <= V

% Take elements and calculate product, flow model(i,i,o):
prodOfArr(_, 0, 1).
prodOfArr(L, K, P):-
    K > 0,
    K1 is K-1,
    select(H,L,Rest),
    prodOfArr(Rest, K1, P1),
    P is H * P1.

% Main predicate, with flow model: (i, i, o):
solve(L, K, V, R):-
    findall(Arr, (length(Arr, K), prodOfArr(L, K, Prod), Prod <= V), R).



% flow model: (i, i, i, o)
arrangements([H|_], 1, H, [H]).
arrangements([_|T], K, P, R) :- arrangements(T, K, P, R).
arrangements([H|T], K, P, [H|R]) :- 
    K > 1, 
    K1 is K - 1, 
    arrangements(T, K1, P1, R), 
    P is H * P1.

% flow model: (i, i, i, o)
solve(L, K, V, R) :- 
    findall(Arr, (arrangements(L, K, P, Arr), P < V), R).