% a. Determine the product of a number represented as digits in a list to a given digit. 
% Eg.: [1 9 3 5 9 9] * 2 => [3 8 7 1 9 8]


product(Digits, Mult, Result) :-
    list_to_number(Digits, Num),
    Prod is Num * Mult,
    number_to_list(Prod, Result).

list_to_number([], 0).
list_to_number([D|Ds], Num) :-
    list_to_number(Ds, Partial),
    length(Ds, N),
    Num is D * 10^N + Partial.

number_to_list(0, [0]).
number_to_list(Num, List) :-
    Num > 0,
    number_to_list_acc(Num, [], List).

number_to_list_acc(0, Acc, Acc).
number_to_list_acc(Num, Acc, List) :-
    Num > 0,
    Digit is Num mod 10,
    NewNum is Num // 10,
    NewAcc = [Digit|Acc],
    number_to_list_acc(NewNum, NewAcc, List).
