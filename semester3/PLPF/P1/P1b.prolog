% alt_sum(List,Sum)
% b. Sum = alternating sum of the List 

alt_sum(List, Sum) :-
    alt_sum(List, 1, 0, Sum).   % Sign is +1, accumulator is 0

% base case for empty list
alt_sum([], _, Acc, Acc).

% recursive case
alt_sum([A|Rest], Sign, Acc, Sum) :-
    NewAcc is Acc + A * Sign,
    NewSign is -Sign,
    alt_sum(Rest, NewSign, NewAcc, Sum).

