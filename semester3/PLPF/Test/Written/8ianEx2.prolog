
f([], -1).
f([H|T], S) :- 
    H > 0,
    f(T,S1),
    S1 < H , !, 
    S is H.
f([_|T], S) :- 
    f(T,S1),
    S is S1.


f([], -1).
f([H|T], S):-
    f(T,S1),
    (H>0, S1<H -> S is H ; S is S1)


% SUBJECT II
% "arrangements" of the len(Array) and K where the k
% numbers have the product = P

% Extract elements and calculate product
% flow model (i, i, o)
prod_arr(0, _, 1).
prod_arr(K, L, P) :-
    K > 0,
    K1 is K - 1,
    select(H, L, Rest), % Select an element (Arrangement)
    prod_arr(K1, Rest, P1),
    P is H * P1.

% Main predicate
% flow model (i, i, i, o)
solve(L, K, P, Res) :-
    findall(Arr, (length(Arr, K), prod_arr(K, L, Prod), Prod =:= P), Res).