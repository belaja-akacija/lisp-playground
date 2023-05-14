;;;; Take a string from stdin and make it scroll across the screen

(defun string->list (str)
  (let ((list-string '()))
    (loop for x from 0 to (- (length str) 1)
          do (push (char str x) list-string))
    (nreverse list-string)))

;; for an element x in the list:
;; clear the screen
;; print from element x to x+3
;; sleep for 1/2 second


;; pop the first element off
;; nreverse the list
;; push it to the list 
;; nreverse it again

(defun scroll (str)
  (let ((list-string (string->list str))
        (temp '()))
    (progn
    (nreverse list-string)
    (push #\Space list-string)
    (nreverse list-string))
    (loop 
      while t
      do (progn 
           (shell "clear")
           (push (pop list-string) temp)
           (nreverse list-string)
           (push (car temp) list-string)
           (nreverse list-string)
           (princ list-string)
           (sleep 0.25)))))

