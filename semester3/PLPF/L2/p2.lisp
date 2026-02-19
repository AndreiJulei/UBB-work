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

; 2. Return the list of nodes on the k-th level of a tree of type (1).

(defun find-nodes-at-level (tree k)
  "Main function: returns only the list of nodes."
  (car (get-nodes-helper tree 0 k)))

(defun get-nodes-helper (tree current-level k)
  "Returns a list: ( (nodes-found) (remaining-tree-elements) )"
  (cond
    ((null tree) (list nil nil))
    
    (t (let* ((node (car tree))
              (child-count (cadr tree))
              (rest (cddr tree)))
         
         (cond
           ;; CASE 1: We are at the target level
           ((= current-level k)
            (list (list node) (skip-subtree-type1 rest child-count)))

           ;; CASE 2: We need to go deeper
           (t (process-children rest child-count (1+ current-level) k)))))))

(defun process-children (tree count level k)
  "Iterates through N children and collects nodes at level k."
  (cond
    ((or (null tree) (= count 0)) (list nil tree))
    (t (let* ((first-child-res (get-nodes-helper tree level k))
              (nodes-from-first (car first-child-res))
              (remaining-after-first (cadr first-child-res))
              
              (other-children-res (process-children remaining-after-first (1- count) level k))
              (nodes-from-others (car other-children-res))
              (remaining-final (cadr other-children-res)))
         
         (list (append nodes-from-first nodes-from-others) remaining-final)))))

(defun skip-subtree-type1 (tree count)
  "Helper to skip subtrees when we've already found our target level."
  (cond
    ((or (null tree) (= count 0)) tree)
    (t (let* ((after-first (skip-subtree-type1 (cddr tree) (cadr tree))))
         (skip-subtree-type1 after-first (1- count))))))