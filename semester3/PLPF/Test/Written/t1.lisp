;; 1. Replace the double call 
(defun f (l)
    (cond
        ((null l) 0)
        ((> (f (car l) 2)) (+ (car l) (f (cdr l))))
        (t (f (car l)))
    )
)
(defun f (l)
    (cond
      ((null l) 0)
      (t ((lambda (res) 
          (cond
            ((> res 2) (+ (car l) (f (cdr l))))
            (t (res))
          )
        )
        (f (car l)))
      )
    )
)

;; SOLUTION:
(defun f (l)
  (cond
    ((null l) 0)
    ;; Pass the current element and the rest of the list to the helper
    (t (f_helper (car l) (cdr l)))))

(defun f_helper (current rest)
  (cond
    ;; If the current number is > 2, add it to the result of processing the rest
    ((> current 2) (+ current (f rest)))
    ;; Otherwise, just process the rest without adding the current number
    (t (f rest))))

(format t "Result: ~a~%" (f '(1 2 3 4)))

;; 3.
(defun f (X &REST Y)
  (cond
    ((null Y) X)
    ;; mapcar #'car Y will take the first element of every list inside Y
    (t (append X (mapcar #'car Y)))))

;; Fixed format string (added 't')
(format t "Result: ~a~%" (append (f '(1 2)) (f '(3 4) '(5 6) '(7 8))))


;; SUBIECTUL III:
(defun replace-level (v k currentLevel)
  (cond
    ((null v) nil) ; Base case: empty list
  
    ((listp (car v)) 
     (cons (replace-level (car v) k (+ currentLevel 1)) 
           (replace-level (cdr v) k currentLevel)))

    ((= currentLevel k) 
     (cons 0 (replace-level (cdr v) k currentLevel)))

    (t 
     (cons (car v) (replace-level (cdr v) k currentLevel)))
  )
)

(defun aux (v k)
  (replace-level v k 1)
)