; 1.1. avoid double call

(defun f (g l)
    (cond
        ((null l) nil)
        (> (funcall g l) 0) (cons (funcall g l) (cdr l))
        (t (funcall g l))
    )
)

; Sol 
(defun f (g l)
    (let (result (funcall g l))
        (cond
            ((null l) nil)
            (> result 0) (cons result (cdr l))
            (t (result))
        )
    )
)

; 1.3. G is now callable through variable P so the final call is
; basically G '(A B C), which is (list (car (A B C)) (car (A B C)))
; Meaning the result is (A A)

; 3. Multiply the numbers on each level with the level
; that they are on. Root is on level 1.

;; Second module flow module (i, i)
(defun multiply-numbers (l level)
    (cond
        ((null l) nil)
        ((numberp l) (* l level))
        ((atom l) l)
        (t (mapcar #'lambda(x) (multiply-numbers x (+ level 1)) l))
    )
)

;; Main module-- flow model(i)
(defun solve (l)
    (multiply-numbers l 1)
)

;; Mathematical module
;; multiply-numbers(l level) =  | if l is number -> l * level
                                | if l is atom -> l
                                | else -> multiply-numbers l (+ lelvel 1).