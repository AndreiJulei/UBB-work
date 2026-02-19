; 10.
; a. Write a function to return the product of all the numerical atoms from a list, at superficial level.
; b. Write a function to replace the first occurence of an element E in a given list with an other element O.
; c. Write a function to compute the result of an arithmetic expression memorised 
; in preorder on a stack. Examples:
;  (+ 1 3) ==> 4 (1 + 3)
;  (+ * 2 4 3) ==> 11 [((2 * 4) + 3)]
;  (+ * 2 4 - 5 * 2 2) ==> 9 ((2 * 4) + (5 - (2 * 2)))
; d. Write a function to produce the list of pairs (atom n), where atom appears for n times in the parameter 
; list. Example:
; (A B A B A C A) --> ((A 4) (B 2) (C 1)).



; a. Prod of all numerical value

(defun parce-for-prod (l totalSum)
    (cond
        ((null l) totalSum)
        ((numberp (car l)) (parce-for-prod (cdr l) (* totalSum (car l))))
        (t (parce-for-prod (cdr l) totalSum))
    )
)

(defun total-prod (l)
    (parce-for-prod l 1)
)

; b. Replace first occ of E with O

(defun replace-first (l e o)
  (cond
    ((null l) nil)
    ((equal (car l) e) (cons o (cdr l))) 
    (t (cons (car l) (replace-first (cdr l) e o)))))

(defun replace-first (l, e)
    (replace-first-with-bool l e 0)
)

; c. 
(defun evaluate-preorder-helper (l)
  (cond
    ((null l) nil)
    ((numberp (car l)) (list (car l) (cdr l)))
    
    (t (let* ((operator (car l))
              (left-res (evaluate-preorder-helper (cdr l)))
              (val1 (car left-res))
              (rest-after-left (cadr left-res))
              
              (right-res (evaluate-preorder-helper rest-after-left))
              (val2 (car right-res))
              (rest-after-right (cadr right-res)))
         
         (list (funcall operator val1 val2) rest-after-right)))))

(defun solve-expression (l)
  (car (evaluate-preorder-helper l)))

; d. Create pairs with the atom and its frequency

(defun count-occ (e l)
  (cond
    ((null l) 0)
    ((equal e (car l)) (+ 1 (count-occ e (cdr l))))
    (t (count-occ e (cdr l)))))

(defun remove-all (e l)
  (cond
    ((null l) nil)
    ((equal e (car l)) (remove-all e (cdr l)))
    (t (cons (car l) (remove-all e (cdr l))))))

(defun create-pairs (l)
  (cond
    ((null l) nil)
    (t (cons (list (car l) (count-occ (car l) l))
             (create-pairs (remove-all (car l) (cdr l)))))))