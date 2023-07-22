;;;; write a function that takes input as an array and then gives the median of the given data in the array.

;;; test global variable
(defparameter test-array (make-array 5 :initial-contents '(2 0 1 7 6)))

(defun swap (arr x y indexes)
  (let* ((temp x)
         (x y)
         (y temp)
         (index1 (car indexes))
         (index2 (cadr indexes)))
    (setf (aref arr index1) x)
    (setf (aref arr index2) y)
    arr))

(defun bubble-sort (arr)
  (loop for i from 0 to (1- (length arr))
        do (loop for j from 0 to (- (length arr) i 1) ; why do we need a nested loop?
                 do (if (> (aref arr j) (aref arr
                                              (if (> (1+ j) (1- (length arr)))
                                                  j
                                                  (1+ j))))
                        (swap arr (aref arr j) (aref arr
                                                     (if (= j (1- (length arr)))
                                                         j
                                                         (1+ j)))
                              `(,j ,(if (= j (1- (length arr)))
                                        j
                                        (1+ j))))))))

;;; Array -> Number
(defun find-median (arr)
"produces the median element of a given array of real numbers"
  (bubble-sort arr)
  (let ((arr-length (length arr)))
    (if (= (mod arr-length 2) 0) ; checks if even or odd length of array
        (/ (+ (aref arr (1- (/ arr-length 2)))
              (aref arr (/ arr-length 2)))
           2)
        (aref arr (1- (/ (+ arr-length 1) 2))))))

;;; tests to verify that the function works. If output nil, tests have passed.
(defun main ()
 (assert (= (find-median (make-array 5 :initial-contents '(5 3 7 6 9))) 6))
 (assert (= (find-median (make-array 7 :initial-contents '(5 3 7 6 9 0 2))) 5))
 (assert (= (find-median (make-array 6 :initial-contents '(5 3 7 6 9 0))) 11/2)))
