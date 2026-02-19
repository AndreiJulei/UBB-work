% Generate a sequence of length 2*N+1, with values -1, 0, 1,
% first element free, last element 0, and |a(i+1)-a(i)| = 1 or 2

generate_sequence(N, Seq) :-
    Len is 2*N + 1,
    length(Seq, Len),
    append(Prefix, [0], Seq),
    fill_sequence(Prefix).

value(-1).
value(0).
value(1).

fill_sequence([]).

fill_sequence([X|Rest]) :-
    value(X),
    fill_sequence(Rest, X).

fill_sequence([], _).

fill_sequence([X|Rest], Prev) :-
    value(X),
    Diff is abs(X - Prev),
    (Diff =:= 1 ; Diff =:= 2),
    fill_sequence(Rest, X).

