; 1.1. avoid double recursive call. Sol:
(defun fcf (f l)
    (let (Result (FUNCALL f (car l)))
        (cond
            ((null l) nil)
            ((Result) (cons (Result) (fct f (cdr l))))
            (t nil)
        )
    )    
)

; 1.3. (A A)

; 3. Replace all elements on odd levels with E

(defun replace-odd-levels (l e currentLevel)
    (cond
        ((null l) nil)
        ((atom l) 
            (cond
                ((= (mod currentLevel 2) 0) e)
                (t (l))
            )
        )
        (t (mapcar #'lambda (x) (replace-odd-levels x e (+ currentLevel 1)) l))
    )
)

(defun solve (l e)
    (replace-odd-levels l e 0)
)