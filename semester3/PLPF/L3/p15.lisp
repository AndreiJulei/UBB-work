
; 15. Write a function that reverses a list together with all its sublists elements, at any level.

(defun deep-reverse (l)
  (cond
    ;; Base case: if it's an atom, it's already "reversed"
    ((atom l) l)
    
    ;; Base case: empty list
    ((null l) nil)
    
    ;; Recursive step: 
    ;; Reverse the rest of the list (CDR), 
    ;; then APPEND the reversed first element (CAR) to the end.
    (t (append (deep-reverse (cdr l)) 
               (list (deep-reverse (car l)))))))