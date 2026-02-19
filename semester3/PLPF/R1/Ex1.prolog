% a. Transform a list in a set.
% b. Determine the union of two sets. The sets are represented as lists.

% remove_all(X, List, Result)
% Remove every occurrence of X from List, producing Result.

remove_all(_, [], []).

remove_all(X, [X|T], R) :-
    remove_all(X, T, R).

remove_all(X, [H|T], [H|R]) :-
    X \= H,
    remove_all(X, T, R).

% remove_duplicates(List, Set)
% Turn a list into a set by removing duplicate occurrences,
% preserving the first occurrence of each element.

remove_duplicates([], []).

remove_duplicates([H|T], [H|R]) :-
    % remove all later copies of H, then continue
    remove_all(H, T, T_no_H),
    remove_duplicates(T_no_H, R).

% occurs_in(X, List)
% True if X appears anywhere in List.

occurs_in(X, [X|_]).

occurs_in(X, [_|T]) :-
    occurs_in(X, T).

% union(List1, List2, Union)
% Produces the union of two sets (lists). Works correctly even if
% inputs contain duplicates (it first removes duplicates).

union(L1, L2, R) :-
    % make sure each input is treated as a set (no duplicates)
    remove_duplicates(L1, S1),
    remove_duplicates(L2, S2),
    union_sets(S1, S2, R).

% union_sets(S1, S2, R)
% Assumes S1 and S2 are sets (no duplicates inside each).
% Result R contains elements of S1 followed by elements of S2
% that are not already in S1 (preserves order).

union_sets([], S2, S2).

union_sets([H|T], S2, R) :-
    occurs_in(H, S2) ->
        % if H already in S2, skip it and continue
        union_sets(T, S2, R)
    ;
        % if H not in S2, keep H and continue
        union_sets(T, S2, Rtail),
        R = [H | Rtail].
