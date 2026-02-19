(defun fct (f l)
    (cond
        ((null l) nil)
        ((FUNCALL f(car l)) (cons FUNCALL f(car l)) fct f (cdr l))
        (t (nil))
    )
)

(defun fct (f l)
    (cond
        ((null l) nil)
        (t(let (res (FUNCALL f (car l)))
            (if res
                (cons res (fct f(cdr l)))
                nil))
        )
    )
)

; SUBJECT III
; replace all nodes on odd levels with an element e
; superficial level is 0 (a (b (g)) (c (d (e) (f))))

(defun replace-odd-nodes (tree e level)
  (cond
    ((null tree) nil)
    ;; Case 1: If we are looking at an atom (a node value)
    ((atom tree) 
     (if (oddp level) e tree))
    
    ;; Case 2: If we are looking at a tree (root . children)
    (t (cons 
        ;; Part A: Process the Root of this tree
        (if (oddp level) e (car tree))
        
        ;; Part B: Process the list of subtrees (the children)
        ;; Note: The children are siblings, so they stay at (level + 1)
        (replace-children (cdr tree) e (+ level 1))))))

(defun replace-children (list-of-trees e next-level)
  (cond
    ((null list-of-trees) nil)
    ;; Process the first subtree, then the rest of the subtrees at the same level
    (t (cons (replace-odd-nodes (car list-of-trees) e next-level)
             (replace-children (cdr list-of-trees) e next-level)))))

(defun main-replace (tree e)
  (replace-odd-nodes tree e 0))


(format t "The tree after replacing odd levels: ~a~%" 
        (replace-odd-nodes '(a (b (g)) (c (d (e)) (f))) 'h 0))

(defun replace-odd (tree e &optional (level 0))
  (cond
    ((null tree) nil)
    ((atom tree) 
     (if (oddp level) e tree))
    (t (cons (if (oddp level) e (car tree))
             (mapcar #'(lambda (subtree) 
                         (replace-odd subtree e (+ level 1))) 
                     (cdr tree))))))

