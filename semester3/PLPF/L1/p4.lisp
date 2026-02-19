; 4.
; a. Write a function to return the sum of two vectors.
; b. Write a function to get from a given list the list of all atoms, on any 
; level, but on the same order. Example:
; (((A B) C) (D E)) ==> (A B C D E)
; c. Write a function that, with a list given as parameter, inverts only continuous
; sequences of atoms. Example:
; (a b c (d (e f) g h i)) ==> (c b a (d (f e) i h g))
; d. Write a list to return the maximum value of the numerical atoms from a list, at superficial level.


; a. Sum of vectors:
(defun sum-of-vector (v sum)
    ((null v) sum)
    (cond
        ((listp (car v)) sum-of-vector (car v) sum)
        ; check if its a nested list
        (t (atomp (car v)) sum-of-vector (cdr v) (+ sum (car v)))
        ; if not add to sum
    )
)

(defun sum-of-vectors (v1 v2)
    (+ (sum-of-vector v1 0) (sum-of-vector v2 0))
)

; b. Turn a non-linear list into a linear one

(defun get-atoms (l)
  (cond
    ((null l) nil)
    ((atom (car l)) (cons (car l) (get-atoms (cdr l))))
    (t (append (get-atoms (car l)) (get-atoms (cdr l))))
  )
)

; c. Invert sequence

(defun invert-seq (l acc)
  (cond
    ((null l) acc)
    ((atom (car l)) (invert-seq (cdr l) (cons (car l) acc)))
    (t (append acc (cons (invert-seq (car l) nil) 
                         (invert-seq (cdr l) nil))))
  )
)

; d. Superficial max
(defun max-superficial (l currentMax)
  (cond
    ((null l) currentMax)
    ((and (numberp (car l)) (or (null currentMax) (> (car l) currentMax)))
     (max-superficial (cdr l) (car l)))
    (t (max-superficial (cdr l) currentMax))
  )
)

