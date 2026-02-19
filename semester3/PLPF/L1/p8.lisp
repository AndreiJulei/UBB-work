; 8.
; a. Write a function to return the difference of two sets.
; b. Write a function to reverse a list with its all sublists, on all levels.
; c. Write a function to return the list of the first elements of all list elements of a given list with an odd 
; number of elements at superficial level. Example:
;  (1 2 (3 (4 5) (6 7)) 8 (9 10 11)) => (1 3 9).
; d. Write a function to return the sum of all numerical atoms in a list at superficial level


; a. Difference of two sets
(defun my-member (e s)
    (cond
        ((null s) nil)
        ((= e (car s)) t)
        (t (my-member e (cdr s)))
    )
)

(defun dif-sets (s1 s2)
    (cond
        ((null s1) nil)
        ((my-member (car s1) s2) (dif-sets (cdr s1) s2))
        (t (cons (car s1) (dif-sets (cdr s1) s2)))
    )
)


; b. b. Deep Reverse (Reverse List and all Sublists)
(defun deep-reverse (l)
  (cond
    ((atom l) l) ; If it's an atom, return as is
    (t (append (deep-reverse (cdr l)) 
               (list (deep-reverse (car l)))))))


; c. first element from all odd sublists
(defun count-on-level (v count)
    (cond
        ((null v) count)
        ((listp (car v)) (count-atoms (cdr v)))
        (t (count-atoms (cdr v) (+ count 1)))
    )
)

(defun first-elements (v first)
    (cond
        ((null v) nill)
        (atom (car v) (cond
            (and (= fisrt 0) (= (mod (count-on-level v 0) 2) 1) (cons (car v) (first-element (cdr v) 1)))
            (t (first-elements (cdr v) first))
        ))
        (t (append (fisrt-element (cdr v) first) (first-element (car v) 0)))
    )
)

; d. Sum of all numerical atoms on superficial level
(defun superficial-sum (v sum)
    (cond
        ((null v) sum)
        ((numberp (car v)) (superficial-sum (cdr v) (+ sum (car v))))
        (t (superficial-sum (cdr v) sum))
    )
)