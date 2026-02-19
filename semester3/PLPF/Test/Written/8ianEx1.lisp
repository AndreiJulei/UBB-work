(defun f (l1 l2)
    (append (f (car l1) l2)
        (cond
            ((null l1) (cdr l2))
            (t (list (f (car l1) l2) (car l2)))
        )
    ) 
)

(DEFUN F (L1 L2)
  (LET ((RES (F (CAR L1) L2)))
    (APPEND RES
            (COND
              ((NULL L1) (CDR L2))
              (T (LIST RES (CAR L2)))
            )
    )
  )
)

% S3

(defun rem-div3 (l)
    (cond
        ((null l) nil)
        ((listp (car l)) (append(list((rem-div3(car l))) (rem-div3 (cdr l)))))
        ((numberp (car l)) 
            (cond
                ((= (mod (car l) 3) 0)
                    (cons nil (rem-div3 (cdr l))))
                (t (cons (car l) (rem-div3 (cdr l))))
            )
        )
        (t (cons (car l) (rem-div3 (cdr l))))
    )
)

(defun rem-div3 (l)
    (cond
        ((null l) nil)
        ;; Case 1: The head is a list. Process it and CONS it to the processed tail.
        ((listp (car l)) 
            (cons (rem-div3 (car l)) (rem-div3 (cdr l))))
        
        ;; Case 2: The head is a number.
        ((numberp (car l)) 
            (cond
                ;; If divisible by 3, replace with NIL and continue
                ((= (mod (car l) 3) 0)
                    (cons nil (rem-div3 (cdr l))))
                ;; Otherwise, keep it and continue
                (t (cons (car l) (rem-div3 (cdr l))))
            )
        )
        
        ;; Case 3: The head is an atom/symbol (like 'A'). Keep it and continue.
        (t (cons (car l) (rem-div3 (cdr l))))
    )
)


 (defun rem-div3 (l)
  (cond
    ((null l) nil)
    ((numberp l) 
     (if (= (mod l 3) 0) nil l)) ; If divisible by 3, return NIL, else return number
    ((atom l) l)                 ; If it's a symbol (like 'A'), keep it
    (t (mapcar #'rem-div3 l))    ; The "Magic": Recurse on every element
  )
)