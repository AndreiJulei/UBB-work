

f([], 0).

f([H|T], S) :-
    f(T, S1),
    S1 < H,
    S is H.

f([_|T], S):-
    f(T, S1),
    S is S1

f([], 0).
f([H|T], S) :- 
    f(T, S1), 
    (H < S1 -> S is H + S1 ; S is S1 + 2).


% S2 find "permutations" with abs(diff) <=3

% checkAbsDiff(List)
checkAbsDiff([]).
checkAbsDiff([H,H2|T]):-
    3 >= H-H2,
    -3 <= H-H2,
    checkAbsDiff([H2|T]).

% Main predicate(List, Solution)
solve(L, S):-
    checkAbsDiff(L),
    S is L.

all_sol(L, R) -:
    findall(S solve(L, S) R).


% Absolute difference check
check([H1, H2 | T]) :-
    Diff is abs(H1 - H2),
    Diff =< 3,
    check([H2 | T]).
check([_]). % Base case: 1 element left
check([]).  % Base case: empty

% Main Predicate
solve(L, Res) :-
    findall(P, (permutation(L, P), check(P)), Res).