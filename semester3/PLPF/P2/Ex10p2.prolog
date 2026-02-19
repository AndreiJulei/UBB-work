% 10.
% a. For a list of integer numbers, define a predicate to write twice in list every prime number.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, define a predicate to write in
% every sublist twice every prime number.
% Eg.: [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5] =>
% [1, [2, 2, 3, 3], 4, 5, [1, 4, 6], 3, [1, 3, 3, 7, 7, 9, 10], 5]


% a. writePrimeTwice(List,Result).

is_prime(2) :- !.
is_prime(N) :-
    integer(N),
    N > 2,
    \+ has_divisor(N, 2).

has_divisor(N, D) :-
    D * D =< N,
    (N mod D =:= 0 ;
     D1 is D + 1,
     has_divisor(N, D1)).

writePrimeTwice([], []).

writePrimeTwice([H|T], [H,H | R]) :-
    is_prime(H), !,
    writePrimeTwice(T, R).

writePrimeTwice([H|T], [H | R]) :-
    writePrimeTwice(T, R).


% b. writePrimeTwice(List,Result)

writePrimeTwiceHeter([], []).

writePrimeTwiceHeter([H|T], [NewH | R]) :-
    is_list(H), !,
    writePrimeTwice(H, NewH),
    writePrimeTwiceHeter(T, R).

writePrimeTwiceHeter([H|T], [H | R]) :-
    writePrimeTwiceHeter(T, R).
