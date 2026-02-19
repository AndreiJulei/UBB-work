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

; 5. Return the level (depth) of a node in a tree of type (1). The level of the root element is 0.

(defun find-level-type1 (tree x level)
  (cond
    ((null tree) nil)
    ;; Case 1: Found the node
    ((equal (car tree) x) level)
    
    ;; Case 2: Not found, search subtrees
    (t 
     (let* ((num-subtrees (cadr tree))
            (left-subtree (cddr tree))) ; Left subtree starts after the number
       
       (if (= num-subtrees 0)
           nil ; No subtrees to search
           
           ;; Search the Left Subtree
           (let ((left-result (find-level-type1 left-subtree x (+ level 1))))
             (if left-result
                 left-result ; Found in left!
                 
                 ;; If not in left, we must SKIP the left subtree to find the right one
                 (if (= num-subtrees 2)
                     (find-level-type1 (skip-subtree left-subtree) x (+ level 1))
                     nil))))))))

;; Helper function to skip a Type (1) subtree
(defun skip-subtree (tree)
  (cond
    ((null tree) nil)
    ((= (cadr tree) 0) (cddr tree)) ; No children, skip node and its '0'
    ((= (cadr tree) 1) (skip-subtree (cddr tree))) ; 1 child: skip node and skip its child
    (t (skip-subtree (skip-subtree (cddr tree)))))) ; 2 children: skip node and skip both subtrees