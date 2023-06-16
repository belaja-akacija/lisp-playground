;#!/home/belajaakacija/.local/bin/sbcl --script
;;;; Take a string from stdin and make it scroll across the screen

-(load "~/quicklisp/setup.lisp")
(ql:quickload "uiop" :silent t)
;(ql:quickload :with-user-abort :silent t)

(defun string->list (str)
  (let ((list-string '()))
    (loop for x from 0 to (- (length str) 1)
          do (push (char str x) list-string))
    (nreverse list-string)))

(defun scroll (str)
  "Scrolls the given text on the screen"
  (let ((list-string (string->list str))
        (temp '()))
    (progn
    (nreverse list-string)
    (push #\Space list-string)
    (nreverse list-string))
    (loop 
      while t
      do (progn 
           ;(format t "~C[h~C[2j" #\Escape #\Escape)
           (format t "~C[2k~C[\r" #\Esc #\Esc)
           (push (pop list-string) temp)
           (nreverse list-string)
           (push (car temp) list-string)
           (nreverse list-string)
           (princ list-string)
           (sleep 0.25)))))

(shell "clear")

;; this disables the cursor. But I don't know how to listen 
;; for a SIGINT signal and handle that to restore the cursor back to its orginal state
;(format t "~C[?25l" #\Esc)

(scroll "I wuv my rowie")
