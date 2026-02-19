; 1.1
(defun fct (f l)
    (cond
        ((null l) nil)
        (t (lambda (res)
            (cons res (fct f (cdr l)))
        )(funcall f (car l)))
    )
)
;; aux function
(defun fct (f l)
    (cond
        ((null l) nil)
        (t (fct_aux (funcall f (car l)) (f (cdr l))))
    )
)

(defun fct_aux (result rest)
    (cons result rest)
)

; 3. Replace Elements on odd levels with E

(defun replace-elements (l e currentLevel)
    (cond
        ((null l) nil)
        ((atom l) 
            (cond
                ((= (mod currentLevel 2) 1) e)
                (t (l))
            )
        )
        (t (mapcar #'(lambda (x) (replace-elements x, e (+ currentLevel 1))) l))
    )
)

(defun solve (l e)
    (replace-elements l e 0)
)



