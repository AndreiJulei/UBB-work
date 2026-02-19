; 11. Write a function to determine the depth of a list.
(defun my-depth (l)
  (cond
    ;; 1. If it's an atom, it doesn't add depth to the structure
    ((atom l) 0)
    
    ;; 2. If it's an empty list, it counts as 1 level
    ((null l) 1)
    
    ;; 3. Compare depth of CAR and depth of CDR
    (t (let ((d1 (1+ (my-depth (car l)))) ; Depth if we go "down" into the sublist
             (d2 (my-depth (cdr l))))     ; Depth if we stay at the current level
         
         ;; Manual MAX logic:
         (if (> d1 d2) d1 d2)))))