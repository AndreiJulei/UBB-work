; 1.
; a. Write a function to return the n-th element of a list, or NIL if such an element does not exist.
; b. Write a function to check whether an atom E is a member of a list which is not necessarily linear.
; c. Write a function to determine the list of all sublists of a given list, on any level. 
; A sublist is either the list itself, or any element that is a list, at any level. Example: 
; (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 sublists :
; ( (1 2 (3 (4 5) (6 7)) 8 (9 10)) (3 (4 5) (6 7)) (4 5) (6 7) (9 10) )
; d. Write a function to transform a linear list into a set.


; a. N-th element of a list
(defun helper (l n count)
    (cond
        ((null l) nil)                      
        ((= n count) (car l))               
        (t (helper (cdr l) n (+ count 1))) 
    )
)

(defun nth-elem (l n)
    (helper l n 1)
)

; b. Check if E is a member of a non-linear list
(defun checkElement (l E)
    (cond 
        ((null l) nil)
        ;; If it's a list, check the sublist OR the rest of the list
        ((listp (car l)) (or (checkElement (car l) E) 
                             (checkElement (cdr l) E)))
        ;; Check if current atom matches
        ((equal (car l) E) t)
        ;; Otherwise, keep going
        (t (checkElement (cdr l) E))
    )
)

; c. Count all sublists
(defun get-sublists (l)
  (cond
    ((atom l) nil) ; If it's an atom, it contains no sublists
    (t (append (list l)                       ; The list itself is a sublist
               (get-sublists (car l))         ; Get sublists from the head
               (get-sublists (cdr l))))       ; Get sublists from the rest
  )
)

; d. Eliminate duplicates
(defun check-duplicates (set elem)
    (cond 
        ((null set) nil)
        ((equal (car set) elem) t)
        (t (check-duplicates (cdr set) elem))
    )
)

(defun eliminate-duplicates (l newSet)
    (cond
        ((null l) newSet) ; When the original list is empty, return the set we built
        
        ;; If (car l) is already in newSet, just skip it and move to (cdr l)
        ((check-duplicates newSet (car l)) 
         (eliminate-duplicates (cdr l) newSet))
        
        ;; If it's NOT in newSet, add it using 'cons' and keep going
        (t (eliminate-duplicates (cdr l) (cons (car l) newSet)))
    )
)

(defun create-set (l)
    (eliminate-duplicates l nil) ; Start with an empty list as the 'newSet'
)