% 12.
% a. Define a predicate to add after every element from a list, the divisors of that number.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, define a predicate to add in 
% every sublist the divisors of every element.
% Eg.: [1, [2, 5, 7], 4, 5, [1, 4], 3, 2, [6, 2, 1], 4, [7, 2, 8, 1], 2] =>
% [1, [2, 5, 7], 4, 5, [1, 4, 2], 3, 2, [6, 2, 3, 2, 1], 4, [7, 2, 8, 2, 4, 1], 2]


% a. add the divisors of each element
% Entry point: Start checking divisors from 2 up to N/2
get_divisors(N, Divs) :- get_divisors_acc(N, 2, Divs).

% Base case: If D is half of N or more, we stop (no need to check higher)
get_divisors_acc(N, D, []) :- D >= N.

% If D is a divisor: add to list and continue
get_divisors_acc(N, D, [D|Rest]) :-
    D < N,
    0 is N mod D,
    D1 is D + 1,
    get_divisors_acc(N, D1, Rest).

% If D is NOT a divisor: skip it and continue
get_divisors_acc(N, D, Rest) :-
    D < N,
    N mod D =\= 0,
    D1 is D + 1,
    get_divisors_acc(N, D1, Rest).
% Add divisors to sublists

% Helper: Takes [2, 4] and returns [2, (no divs), 4, 2] -> [2, 4, 2]
% Based on your example, it looks like we append the divisors at the end 
% or after each element. Let's follow the example's "after each element" logic.

process_flat_list([], []).
process_flat_list([H|T], Result) :-
    get_divisors(H, Divs),
    process_flat_list(T, Rest),
    append([H|Divs], Rest, Result). % Flattens H + its divisors into the list

% If it's a number, keep it as is and move on.
solve_hetero([], []).
solve_hetero([H|T], [H|R]) :-
    number(H),
    solve_hetero(T, R).

% If it's a list, process it to add divisors, then move on.
solve_hetero([H|T], [NewSub|R]) :-
    is_list(H),
    process_flat_list(H, NewSub),
    solve_hetero(T, R).