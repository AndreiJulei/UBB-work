; 1.1 Avoid double recursion of f (car l)

(defun f (l)
    (cond
        ((atom l) -1)
        ((> (f (car l) 0)) (+ (car l) (f (car l)) (f (cdr l))))
        (t (f (cdr l)))
    )
)

;; Solution:
(defun f (l)
    (cond
        ((atom l) -1)
        (t (f_helper (f car l) (car l) (cdr l)))
    )
)

(defun f (res_car current rest) 
    (cond
        ((> res_car 0) (+ current (f rest)))
        (t (f rest))
    )   
)

; 1.3 labda (l) ? funcall (cdr l)-> (2,3)

; 3. Replace all even numbers with the next number using a MAP funciton

(defun replaceEven (L)
    (cond 
        ((null L) nil)
        ((numberp L) 
            (if (evenp L) (+ L 1) L))
        (t (cons (if (evenp (car L) (+ (car L) 1) (car L)))
                (mapcar #'lambda ((cdr l))
                    (replceEven (cdr l)))))
    )
)


(defun replace-even (l)
  (cond
    ((null l) nil)
    ((numberp l) (if (evenp l) (+ l 1) l))
    ((atom l) l)
    (t (mapcar #'replace-even l))))