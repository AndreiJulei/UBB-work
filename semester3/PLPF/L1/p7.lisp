; 7.
; a. Write a function to eliminate the n-th element of a linear list.
; b. Write a function to determine the successor of a number represented digit by digit as a list, without 
; transforming the representation of the number from list to number. Example: (1 9 3 5 9 9) --> (1 9 3 6 0 0)
; c Write a function to return the set of all the atoms of a list.
; Exemplu: (1 (2 (1 3 (2 4) 3) 1) (1 4)) ==> (1 2 3 4)
; d. Write a function to test whether a linear list is a set.

; a. Eliminate n-th element
(defun eliminate-element (v n)
    (cond
        ((null v) nill)
        ((= n 1) (cdr v)) ; we concatenate with the cdr of the list when we find the element 
        (t (cons (car v) (eliminate-element (cdr v) (- n 1))))
    )
)

; b. Succesor of a number represented as a list
(defun my-reverse (l acc)
  (cond
    ((null l) acc)
    (t (my-reverse (cdr l) (cons (car l) acc)))))

(defun succesor (v carry)
  (cond 
    ;; If list is empty and there's still a carry (e.g., 99 + 1), add the 1
    ((and (null v) (= carry 1)) (list 1))
    ((null v) nil)
    (t (let* ((sum (+ (car v) carry))
              (digit (mod sum 10))
              (new-carry (floor (/ sum 10))))
         (cons digit (succesor (cdr v) new-carry))))))

(defun succesor-list (l)
  (my-reverse (succesor (my-reverse l nil) 1) nil)
)

; c. Return all atoms (w/o duplicates)
(defun linearize (v)
  (cond
    ((null v) nil)
    ((atom (car v)) (cons (car v) (linearize (cdr v))))
    (t (append (linearize (car v)) (linearize (cdr v))))))

(defun make-set (v)
  (cond
    ((null v) nil)
    ((member (car v) (cdr v)) (make-set (cdr v)))
    (t (cons (car v) (make-set (cdr v))))))

(defun all-atoms-set (v)
  (make-set (linearize v)))

; d. Test if a linear list is a set
(defun is-set (v)
  (cond
    ((null v) t)
    ((member (car v) (cdr v)) nil) ; If found in rest, it's not a set
    (t (is-set (cdr v)))
  )
)