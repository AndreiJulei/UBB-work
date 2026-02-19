% valley(List)
% a. Check if a list has a 'valley'

valley([A,B|Rest]) :-
	A > B,						% start decreasing
	valley_down([A,B|Rest]).

% first half: decreasing until we find a number bigger than the current number

valley_down([A,B|Rest]) :-	
	( B < A -> 
		valley_down([B|Rest]);
	B > A ->
		valley_up([B|Rest]) 
).

% second half must be strictly increasing

valley_up([A,B|Rest]) :-
	B > A,
	valley_up([B|Rest]).

valley_up([_]).		% if it reached the end it succeded



% Examples:
% Good case:
% valley([10,8,6,9,10]).

% Bad case:
% valley([10,8,6,7,5]).