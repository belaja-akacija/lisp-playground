;; Write a program that finds the summation of every number from 1 to num. The number will always be a positive integer greater than 0.

;; 2 -> 3 (1 + 2)
;; 5 -> 15 (1 + 2 + 3 + 4 + 5)

;; Method:
;; 1. take orginal value and store it into a list
;; 2. take the original value and subtract it by one and store it in the list
;; 3. do step 2 until the value is 0
;; 4. sum up every index in the list and return the value

(defun summation (n)
  (let ((x '())
        (a n))
    (cond 
      ((null n) 0)
      (t 
        (loop while (> a 0)
              do (setq x (cons a x))
              (setq a (- a 1)))
        (reduce #'+ x)))))
