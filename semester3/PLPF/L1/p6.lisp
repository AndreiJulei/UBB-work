; 6.
; a. Write a function to test whether a list is linear.
; b. Write a function to replace the first occurence of an element E in a given list with an other element O.
; c. Write a function to replace each sublist of a list with its last element.
; A sublist is an element from the first level, which is a list.
; Example: (a (b c) (d (e (f)))) ==> (a c (e (f))) ==> (a c (f)) ==> (a c f)
; (a (b c) (d ((e) f))) ==> (a c ((e) f)) ==> (a c f)
; d. Write a function to merge two sorted lists without keeping double values


; a. Test if a list is linear

(defun test-linear (v)
    (cond
        ((null v) t)
        ((listp (car v)) nil)
        (t (test-linear (cdr v)))
    )
)

; b. Replace first instance with 0
(defun replace-first (v e o)
  (cond
    ((null v) nil)
    ((equal (car v) e) (cons o (cdr v))) ; Found it! Replace and stop searching.
    ((listp (car v)) (cons (replace-first (car v) e o) (cdr v))) ; Search inside sublist
    (t (cons (car v) (replace-first (cdr v) e o)))
  )
)
; c. Replace sublists with their last element 
(defun get-last (l)
    (cond
        ((atomp l) l)
        ((null (cdr l)) (get-last (car l)))
        (t (get-last (cdr l)))
    )
)

(defun replace-sublists (v)
    (cond 
        ((null v) nill)
        ((listp (car v)) (cons (get-last (car v)) (replace-sublists (cdr v))))
        (t (cons (car v) (replace-sublists (cdr v))))
    )
)

; d. merge two sorted lists without duplicates
(defun merge-sorted (v1 v2)
    (cond 
        ((null v1) v2)
        ((null v2) v1)
        ((= (car v1) (car v2)) (cons (car v1) (merge-sorted (cdr v1) (cdr v2))))
        ((< (car v1) (car v2)) (cons (car v1) (merge-sorted (cdr v1) v2)))
        (t (cons (car v2) (merge-sorted v1 (cdr v2))))
    )
)
