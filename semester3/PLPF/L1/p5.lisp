5.
; a. Write twice the n-th element of a linear list. Example: for (10 20 30 40 50) and n=3 will produce (10 
; 20 30 30 40 50).
; b. Write a function to return an association list with the two lists given as parameters. 
; Example: (A B C) (X Y Z) --> ((A.X) (B.Y) (C.Z)).
; c. Write a function to determine the number of all sublists of a given list, on any level. 
; A sublist is either the list itself, or any element that is a list, at any level. Example: 
; (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 lists:
; (list itself, (3 ...), (4 5), (6 7), (9 10)).
; d. Write a function to return the number of all numerical atoms in a list at superficial level.


; a. Duplicate the n-th element

(defun duplicate-elem (l n)
    (cond
        ((null l) nill)
        (= n 1) (cons (carl) (cons (car l) (duplicate-elem (cdr l) 0)))
        (t (cons (car l) (duplicate-elem (cdr l) (- n 1))))
    )
)

; b. Pair emelents from two vectors

(defun pair-elem (v1 v2)
  (cond
    ((or (null v1) (null v2)) nil)
    (t (cons (cons (car v1) (car v2)) 
             (pair-elem (cdr v1) (cdr v2))))
  )
)

; c. Count number of lists
(defun count-helper (l count)
  (cond
    ((null l) count)
    ((listp (car l)) 
     (count-helper (cdr l) (count-helper (car l) (+ count 1))))
    (t (count-helper (cdr l) count))
  )
)

(defun count-lists (l)
  (count-helper l 1) ; 1 for the main list itself
); d. Count superficial

(defun count-num-superficial (l)
  (cond
    ((null l) 0)
    ((numberp (car l)) (+ 1 (count-num-superficial (cdr l))))
    (t (count-num-superficial (cdr l)))
  )
)