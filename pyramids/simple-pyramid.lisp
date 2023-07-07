(defun pyramid-numbers (num)
  (let ((pyramid-number 0))
    (loop for x from 0 to num
          collect (setf pyramid-number (if (equal pyramid-number 0)
                                           1
                                        (+ pyramid-number 2))))))

(pyramid-numbers 10)

(defun print-pyramid (num-list count)
  (if (null num-list)
      nil
      (progn
        (format t "~A~%" (concatenate 'string
                            (make-string count
                                         :element-type 'character
                                         :initial-element #\Space)
                            (make-string (car num-list)
                                         :element-type 'character
                                         :initial-element #\#)))
        (print-pyramid (cdr num-list) (1- count)))))

(print-pyramid (pyramid-numbers 10) 10)

