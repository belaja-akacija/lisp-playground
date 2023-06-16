(defun summation (n)
  (labels ((sum-helper (n i sum)
             (if (> i n)
                 sum
                 (sum-helper n (1+ i) (+ sum i)))))
    (sum-helper n 0 0)))

;; "best practise" code from codewars
(defun sum-refactor (n)
  (loop for i from 1 to n
        summing i)) ; what does this "summing" do?
