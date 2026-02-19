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


;;; a. Dot product
(defun dot-product (v1 v2)
  "Return the dot product of two vectors V1 and V2."
  (apply #'+ (mapcar #'* v1 v2)))

(format t "Dot product of (1 2 3) and (1 2 3): ~a~%" 
        (dot-product '(1 2 3) '(1 2 3)))



;;; b. Maximum numerical atom in nested list
(defun max-numerical-atom (x)
  "Return the maximum number in a nested list X, or NIL if none."
  (cond
    ((null x) nil)
    ((atom x) (if (numberp x) x nil))
    (t (let ((a (max-numerical-atom (car x)))
             (b (max-numerical-atom (cdr x))))
         (cond
           ((and a b) (max a b))
           (a a)
           (b b)
           (t nil))))))

(format t "Max numerical atom in '((1 2) (3 (4 5)) 6)': ~a~%" 
        (max-numerical-atom '((1 2) (3 (4 5)) 6)))



;;; c. Evaluate prefix arithmetic expression
(defun eval-prefix (expr)
  "Evaluate a prefix expression EXPR. EXPR is a list in preorder."
  (cond
    ((numberp expr) expr)
    ((atom expr) (error "Invalid expression: ~a" expr))
    (t (let ((op (car expr))
             (args (cdr expr)))
         (cond
           ((eq op '+) (+ (eval-prefix (car args))
                          (eval-prefix (cadr args))))
           ((eq op '-) (- (eval-prefix (car args))
                          (eval-prefix (cadr args))))
           ((eq op '*) (* (eval-prefix (car args))
                          (eval-prefix (cadr args))))
           ((eq op '/) (/ (eval-prefix (car args))
                          (eval-prefix (cadr args))))
           (t (error "Unknown operator: ~a" op)))))))

(format t "Eval '(+ 1 3)': ~a~%" (eval-prefix '(+ 1 3)))
(format t "Eval '(+ (* 2 4) 3)': ~a~%" (eval-prefix '(+ (* 2 4) 3)))
(format t "Eval '(+ (* 2 4) (- 5 (* 2 2)))': ~a~%" 
        (eval-prefix '(+ (* 2 4) (- 5 (* 2 2)))))



;;; d. Check even number of top-level elements
(defun even-top-level-p (lst)
  (cond
    ((null lst) t)           ; empty list → even
    ((null (cdr lst)) nil)   ; one element → odd
    (t (even-top-level-p (cddr lst))))) ; skip two elements

(format t "Even top-level elements in '(1 2 3 4)': ~a~%" 
        (even-top-level-p '(1 2 3 4)))

(format t "Even top-level elements in '(a b c)': ~a~%" 
        (even-top-level-p '(a b c)))
