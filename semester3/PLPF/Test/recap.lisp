; 1.1 
(defun f(L1 L2)
    (append (f (car L1) L2)
        (cond
            ((null L1) (cdr L2))
            (t (list (f (car L1) L2) (car L2)) )
        )
    )
)

;; Sol lambda
(defun f (L1 L2)
  (cond
    ((null L1) (cdr L2)) ; Base case must come first to prevent infinite recursion
    (t ((lambda (res)
          (append res (list res (car L2))))
        (f (car L1) L2)))))

;; Sol aux func
(defun f (L1 L2)
  (cond
    ((null L1) (cdr L2))
    (t (f_helper (f (car L1) L2) (car L2)))))

(defun f_helper (res_car car_l2)
  (append res_car (list res_car car_l2)))



; 1.3. Sol: (1 2 2 2)
; 3. Remove all numbers divisible with 3

(defun solve (l)
    (cond
        ((null l) nil)
        ((numberp l)
            (cond
                ((= (mod l 3) 0) nil)
                (t (l))
            )
        )
        ((atom l) l)
        (t (mapcar #'solve (cdr l)))
    )   
)

