; 1.1. Avoid double recursion call f (car l)

(defun f (l)
    (cond
        ((null l) nil)
        ((listp (car l)) 
            (append (f (car l)) (f (cdr l)) (car (f (car l)))))
        (t (list (car l)))
    )
)

; Solution
(defun f (l)
        (cond
            ((null l) nil)
            (t ((lambda (res) (if (listp res) 
                (append res (f (cdr l) (car res))) 
                (list (car l))
                            ))(f (car l))))
        )
)

; 1.3. Solution: (2 3 5 6)

; 3. Replace all values E with E1 on odd levels 
;; Superficial level is 1
;;; Use MAP funciton

(defun replace-on-odd (l e e1 level)
  (cond
    ((null l) nil)

    ;; If it's the target element at an odd level, replace it
    ((and (atom l) (oddp level) (eq l e)) e1)
    
    ;; If it's any other atom (number or symbol), leave it alone
    ((atom l) l)
    
    ;; If it's a list, use mapcar to dive into every element
    (t (mapcar #'(lambda (x) (replace-on-odd x e e1 (+ 1 level))) 
               l))))

(defun solve (l e e1) (replace-on-odd l e e1 1))