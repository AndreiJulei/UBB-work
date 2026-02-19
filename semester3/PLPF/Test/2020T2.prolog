% 1.2 
f([], -1).
f([H|T], S):-
    f(T, S1),
    f_aux(H, S1, S).

f_aux(E, S1, S):-
    E > 0,
    S1 < E, !,
    S is H.
f_aux(E, S1, S):-
    S is S1.

% 2.
insert(E, L, [E|L]).
insert(E, [H|T], [H|R]):-
    insert(E, T, R).

arrangements([E|_], 1, [E]).
arrangements([_|T], K, R) :-
    arrangements(T, K, R).
arrangements([H|T], K, R1) :-
    K > 1,
    K1 is K-1,
    arrangements(T, K1, R),
    insert(H, R, R1).

checkProd([],1).
checkProd([H|R], Prod):-
    checkProd(R,P1),
    Prod is P1 * H.

solve(L, K, P, Result):-
    findall(Arr, (arrangements(L, K, Arr), checkProd(Arr, NewProd), NewProd =:= P), Result)
