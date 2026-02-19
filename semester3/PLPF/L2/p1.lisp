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


; 1. For a given tree of type (1) return the path from the root node to a certain given node X.

(defun skip-subtree (tree)
  "Returns the remainder of the list after skipping one full subtree."
  (cond
    ((null tree) nil)
    ((zerop (cadr tree)) (cddr tree)) ; No children: skip node and its '0' count
    (t (let* ((after-left (skip-subtree (cddr tree)))) ; Skip left subtree
         (skip-subtree after-left)))))                 ; Skip right subtree

(defun get-path (tree x)
  (cond
    ((null tree) nil)
    ;; Case 1: Found the node
    ((eq (car tree) x) (list x))
    ;; Case 2: Check children
    (t (let* ((node (car tree))
              (child-count (cadr tree)))
         (if (zerop child-count)
             nil ; Leaf node and not X
             (let* ((left-subtree (cddr tree))
                    ;; Look for X in the left path
                    (left-path (get-path left-subtree x)))
               (if left-path
                   (cons node left-path) ; Found in left!
                   ;; Not in left, skip left to find the right subtree
                   (let* ((right-subtree (skip-subtree left-subtree))
                          (right-path (get-path right-subtree x)))
                     (if right-path
                         (cons node right-path) ; Found in right!
                         nil)))))))))            ; Not in either