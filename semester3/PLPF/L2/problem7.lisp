; Write recursive Lisp functions for the following problems (optionally, you may use MAP functions):
; A binary tree is memorised in the following two ways:
; (node no-subtrees list-subtree-1 list-subtree-2 ...) (1)
; (node (list-subtree-1) (list-subtree-2) ...) (2)
; As an example, the tree
;  A
; / \
; B C
;  / \
;  D E
; is represented as follows:
; (A 2 B 0 C 2 D 0 E 0) (1)
; (A (B) (C (D) (E))) (2)

; 7. Return the level of a node X in a tree of type (1). The level of the root element is 0.


(defun level-of-node (tree x)
  (car (find-node tree x 0)))


(defun find-node (tree x level)
  ;; tree begins with (node number-of-children ...)
  (let* ((node (car tree))
         (child-count (cadr tree))
         (rest (cddr tree)))

    ;; If this is the node we’re searching for
    (when (equal node x)
      (return-from find-node (cons level rest)))

    ;; Otherwise search each child subtree
    (find-in-children rest child-count x level)))


(defun find-in-children (rest child-count x level)
  ;; No children → not found
  (if (= child-count 0)
      (cons nil rest)   ; not found, rest unchanged

      ;; Otherwise:
      (let ((result (find-node rest x (+ level 1))))
        (if (car result)  
            ;; Found in the first subtree → return immediately
            result

            ;; Not found → move rest past this subtree and continue
            (find-in-children (cdr result) (- child-count 1) x level)))))


(format t "The level of the given node is: ~a~%" (level-of-node '(A 2 B 0 C 2 D 0 E 0) 'E))
