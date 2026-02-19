; 5. Write a function that computes the sum of even numbers and the decrease the sum of odd numbers, 
; at any level of a list


(defun process-number (n)
    (cond
        ((evenp n) n)       ;; add if n is even
        ((oddp n) (- n))     ;; subtract if n is odd
        (t 0)
    )
)


(defun sum-even-sub-odd (lst)
    (cond
        ((null lst) 0)

        ((atom (car lst))   
            ( + 
                (process-number (car lst))
                (sum-even-sub-odd (cdr lst))
            )
        )
        (t
            ( + 
                (sum-even-sub-odd (car lst))
                (sum-even-sub-odd (cdr lst))
            )
        )
    )
)

(format t "The sum of the even numbers and the decrease of odd dumbers is: ~a~%"
        (sum-even-sub-odd '(1 2 (3 4) (5 (6)))))


% Mathematical formula:
% processNumber(N) = | N, if N is even;
%                    | -N, if N is odd;
%                    | 0, otherwise (not a number).

% sumEvenSubOdd(L) = | 0, if L is empty;
%                    | processNumber(head(L)) + sumEvenSubOdd(tail(L)), if head(L) is an atom;
%                    | sumEvenSubOdd(head(L)) + sumEvenSubOdd(tail(L)), if head(L) is a list.