; 1.Show nodes in preorder inorder and post order

(defun skip-subtree (l count)
    (cond
        ((null l) nil)
        ((= count 0) l)
        (t (skip-subtree (cddr l) (+ (- count 1) (cadr l))))))

(defun get-left-child (l)
  (cddr l)) 

(defun get-right-child (l)
  (skip-subtree (cddr l) 1))

(defun solve-preorder (l)
  (cond
    ((null l) nil)
    (t (let ((node (car l))
             (count (cadr l)))
         (cond
           ((= count 0) (list node))
           ((= count 1) (cons node (solve-preorder (get-left-child l))))
           (t (append (list node) 
                      (solve-preorder (get-left-child l)) 
                      (solve-preorder (get-right-child l)))))
    ))
))

;; Preorder: Center - Left - Right.
(format t "Preorder: ~a~%" (solve-preorder '(E 2 F 2 C 0 J 1 K 0 B 2 D 2 G 0 I 0 A 1 H 0)))

;; Inorder: Left - Center - Right
(defun solve-inorder (l)
  (cond
    ((null l) nil)
    (t (let ((node (car l))
             (count (cadr l)))
         (cond
           ((= count 0) (list node))
           ((= count 1) (append (solve-inorder (get-left-child l)) (list node)))
           (t (append (solve-inorder (get-left-child l)) 
                      (list node) 
                     (solve-inorder (get-right-child l)))
            )
            )
        )
    )
    )                  
)
(format t "Inorder: ~a~%" (solve-inorder '(E 2 F 2 C 0 J 1 K 0 B 2 D 2 G 0 I 0 A 1 H 0)))

;; Postorder: Left - Right - Center
(defun solve-postorder (l)
  (cond
    ((null l) nil)
    (t (let ((node (car l))
             (count (cadr l)))
         (cond
           ((= count 0) (list node))
           ((= count 2)(append (solve-postorder (get-left-child l)) 
                      (solve-postorder (get-right-child l)) 
                      (list node)))
            (t (append (solve-postorder (get-left-child l)) (list node)))
          )
          
            
            ))))

          
(format t "Preorder: ~a~%" (solve-postorder '(E 2 F 2 C 0 J 1 K 0 B 2 D 2 G 0 I 0 A 1 H 0)))
