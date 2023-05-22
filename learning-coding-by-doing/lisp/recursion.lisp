;;;; Practising recursive functions

(defun enumerate (num itr)
  (if (> num itr) '()
      (cons num (enumerate (1+ num) itr))))

(defun back-and-forth (num times) 
  "goes back and forth between a number x and x+1, n times"
  (defun bnf-helper (num times itr) 
    (if (equal itr times) '()
        (cons num (bnf-helper (if (equal (mod itr 2) 0) (1+ num) (1- num)) times (1+ itr)))))
  (bnf-helper num times 0))
