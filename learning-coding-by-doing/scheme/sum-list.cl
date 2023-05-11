(defun part-sums (ls)
  (let ((sums '()))
  (cond
    ((null ls)
     '())
    ((null (car ls))
     (setq sums (push 0 sums)))
    ((setq sums (push (reduce #'+ ls) sums))
     (format t "sums list: ~a~%" sums)
     (setq new-list (cdr (reverse ls)))
     (format t "new-list: ~a~%" new-list)
     (part-sums new-list)))))

;; Take original list
;; add all elements together
;; store sum in a new list
;; remove first element from the original list
;; recur the function with the new list without first value as the argument
;; repeat until list is empty
