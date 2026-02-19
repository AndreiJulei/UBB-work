; 3.
; a. Write a function that inserts in a linear list a given atom A after the 2nd, 4th, 6th, ... element.
; b. Write a function to get from a given list the list of all atoms, on any 
; level, but reverse order. Example:
; (((A B) C) (D E)) ==> (E D C B A)
; c. Write a function that returns the greatest common divisor of all numbers in a nonlinear list.
; d. Write a function that determines the number of occurrences of a given atom in a nonlinear list


; a. Insert on even positions
(defun helper-insert (l elem count)
  (cond
    ((null l) nil)
    ((= (rem count 2) 0) 
     (cons (car l) (cons elem (helper-insert (cdr l) elem (+ count 1)))))
    (t (cons (car l) (helper-insert (cdr l) elem (+ count 1))))
  )
)

(defun insert-even (l elem)
  (helper-insert l elem 1)
)

; b. Get the reverse order of the atoms

(defun gather-rev (l acc)
  (cond
    ((null l) acc)
    ((atom (car l)) (gather-rev (cdr l) (cons (car l) acc)))
    (t (gather-rev (cdr l) (gather-rev (car l) acc)))
  )
)

(defun get-reversed (l)
  (gather-rev l nil)
)

; c. GCD

(defun gcd-2 (a b)
  (if (= b 0) a (gcd-2 b (rem a b))))

(defun gcd-list (l)
  (cond
    ((null l) 0)
    ((numberp l) l)
    ((atom l) 0)
    (t (let ((g1 (gcd-list (car l)))
             (g2 (gcd-list (cdr l))))
         (cond 
           ((zerop g1) g2)
           ((zerop g2) g1)
           (t (gcd-2 g1 g2)))))
  )
)

; d. Number of apparences of an atom
(defun count-app (l elem)
  (cond
    ((null l) 0)
    ((equal l elem) 1)
    ((atom l) 0)
    (t (+ (count-app (car l) elem) 
          (count-app (cdr l) elem)))
  )
)