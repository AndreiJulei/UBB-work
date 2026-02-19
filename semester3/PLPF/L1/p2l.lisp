; 2.
; a. Write a function to return the product of two vectors.
; https://en.wikipedia.org/wiki/Dot_product
; b. Write a function to return the depth of a list. Example: the depth of a linear list is 1.
; c. Write a function to sort a linear list without keeping the double values.
; d. Write a function to return the intersection of two sets.


; a. product of two vectors
(defun helper-prod (v1 v2 sum)
  (cond
    ((or (null v1) (null v2)) sum) ; Return the accumulated sum at the end
    (t (helper-prod (cdr v1) (cdr v2) (+ (* (car v1) (car v2)) sum)))
  )
)

(defun vector-product (v1 v2)
  (helper-prod v1 v2 0)
)

(format f "product of (1 2 3) and (1 2 -3): ~a~%"
        (vector-product '(1 2 3) '(1 2 -3)))

; b. Depth of a list

(defun 2nd-helper (v1 count maxcount)
    (cond
        ((nill v1) null)    ;base case
        (lisp (car v1)) (or (2nd-helper (car v1) (+ count 1))
                            2nd-helper (cdr v1) count maxcount)
        (cond
            (> count maxcount) (or (2nd-helper (cdr v1) (- count 1) count)
                                    2nd-helper (cdr v1) count maxcount)
        )
    )
)

(defun count-depth (v1)
    (2nd-helper v1 1 1)
)

(format f "count ((1) 1 (1 (1))): ~a~%"
        (count-depth '((1) 1 (1 (1)))) )

; c. Sort a linear list without doubles 

(defun insert-sorted (elem l)
  (cond
    ((null l) (list elem))
    ((= elem (car l)) l) ; If duplicate, don't add it
    ((< elem (car l)) (cons elem l))
    (t (cons (car l) (insert-sorted elem (cdr l))))
  )
)

(defun sort-linear (l)
  (cond
    ((null l) nil)
    (t (insert-sorted (car l) (sort-linear (cdr l))))
  )
)

; d. Intersection of two sets

(defun is-member (elem set)
  (cond
    ((null set) nil)
    ((equal elem (car set)) t)
    (t (is-member elem (cdr set)))
  )
)

(defun intersection-sets (s1 s2)
  (cond
    ((null s1) nil)
    ((is-member (car s1) s2) 
     (cons (car s1) (intersection-sets (cdr s1) s2))) ; It's in both!
    (t (intersection-sets (cdr s1) s2)) ; Not in both, skip it
  )
)
