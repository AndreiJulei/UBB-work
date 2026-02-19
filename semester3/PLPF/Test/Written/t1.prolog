%% 2. Dont use the recursive call f(T,S1) in both clauses

f([], 0).

f([H|T], S):-
    f(T, S1),
    H<S1,!,
    S is H + S1.

f([_|T], S):- 
    S is 2.


%% SUBJECT II: 
% sum_list(List, Sum)
sum_list([], 0).
sum_list([H|T], S) :- sum_list(T, S1), S is H + S1.

% length_list(List, Length)
length_list([], 0).
length_list([_|T], L) :- 
    length_list(T, L1), 
    L is L1 + 1.

% subset(InputList, OutputSubset)
subset([], []).
subset([H|T], [H|Res]) :- subset(T, Res).
subset([_|T], Res) :- subset(T, Res).

% main_predicate(L, N, Result)
solve(L, N, S) :- 
    subset(L, S), 
    length_list(S, Len), Len >= N, 
    sum_list(S, Sum), Sum mod 3 =:= 0.

all_solutions(L, N, R) :- findall(S, solve(L, N, S), R).