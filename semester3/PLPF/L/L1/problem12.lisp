; 12.
; a. Write a function to return the dot product of two vectors. https://en.wikipedia.org/wiki/Dot_product
; b. Write a function to return the maximum value of all the numerical atoms of a list, at any level.
; c. All permutations to be replaced by: Write a function to compute the result of an arithmetic expression
; memorised in preorder on a stack. Examples:
; (+ 1 3) ==> 4 (1 + 3)
; (+ * 2 4 3) ==> 11 [((2 * 4) + 3)]
; (+ * 2 4 - 5 * 2 2) ==> 9 ((2 * 4) + (5 - (2 * 2)))
; d.Write a function to return T if a list has an even number of elements on the first level, and NIL on the 
; contrary case, without counting the elements of the list


; a. Dot product
(defun dot-product (v1 v2)
  (cond
    ((or (null v1) (null v2)) 0)
    (t (+ (* (car v1) (car v2))
          (dot-product (cdr v1) (cdr v2))))
  )
)

(format t "Dot product of (1 2 3) and (1 2 3): ~a~%"
        (dot-product '(1 2 3) '(1 2 3)))

% Mathematical formula:
% dotProduct(V1, V2) = | 0, if V1 or V2 is empty;
%                      | (V1_1 * V2_1) + dotProduct(V1_rest, V2_rest), otherwise.

; b. Maximum numerical atom in nested list
(defun max-numerical-atom (x)
  (cond
    ((null x) nil)

    ((atom x)
     (if (numberp x) x nil))

    (t
      (let ((a (max-numerical-atom (car x)))
            (b (max-numerical-atom (cdr x))))
        (cond
          ((and a b) (if (> a b) a b))
          (a a)
          (b b)
          (t nil)
        )
      )
    )
  )
)

(format t "Max numerical atom in '((1 2) (3 (4 5)) 6)': ~a~%"
        (max-numerical-atom '((1 2) (3 (4 5)) 6)))

% Mathematical formula:
% maxAtom(L) = | nil, if L is empty;
%              | L, if L is a number;
%              | nil, if L is an atom but not a number;
%              | max(maxAtom(L_head), maxAtom(L_tail)), if L is a list.
%

; c. Evaluate prefix arithmetic expression
(defun eval-prefix (expr)
  (cond
    ;; if it's a number, return it
    ((numberp expr) expr)

    ;; otherwise expr is a list
    (t
      (let ((op (car expr))
            (x  (cadr expr))
            (y  (caddr expr)))
        (cond
          ((eq op '+) (+ (eval-prefix x) (eval-prefix y)))
          ((eq op '-) (- (eval-prefix x) (eval-prefix y)))
          ((eq op '*) (* (eval-prefix x) (eval-prefix y)))
          ((eq op '/) (/ (eval-prefix x) (eval-prefix y)))
          (t (error "Wrong operator: ~a" op))
        )
      )
    )
  )
)

(format t "Eval '(+ 1 3)': ~a~%" (eval-prefix '(+ 1 3)))
(format t "Eval '(+ (* 2 4) 3)': ~a~%" (eval-prefix '(+ (* 2 4) 3)))
(format t "Eval '(+ (* 2 4) (- 5 (* 2 2)))': ~a~%"
        (eval-prefix '(+ (* 2 4) (- 5 (* 2 2)))))

% Mathematical formula:
% eval(E) = | E, if E is a number;
%           | eval(left) op eval(right), if E is a list (op left right).
%
% * And op is one of the following: {+, -, *, /}

; d. Even number of top-level elements
(defun even-top-level-p (lst)
  (cond
    ((null lst) t)
    ((null (cdr lst)) nil)
    (t (even-top-level-p (cddr lst)))
  )
)

(format t "Even top-level elements in '(1 2 3 4)': ~a~%"
        (even-top-level-p '(1 2 3 4)))

(format t "Even top-level elements in '(a b c)': ~a~%"
        (even-top-level-p '(a b c)))

% Mathematical formula:
% isEven(L) = | T, if L is empty;
%             | NIL, if L has exactly one element;
%             | isEven(L_rest_rest), if L has at least two elements.
