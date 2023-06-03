(defparameter *refresh-rate* 0.25)
(defparameter *screen-x* 100)
(defparameter *screen-y* 100)

(defun refresh-screen ()
  (loop for x from 0 to 10
       do (progn
            (shell "clear")
            (format t "~a" (string (char "hello world" x)))
            (sleep *refresh-rate*)
            )))

(defparameter *board* (make-array '(3 3) :initial-element '-))

(defun display-board (board)
  (dotimes (x 3)
    (dotimes (y 3)
      (if (= y 2) 
          (format t "~A~%" (aref board x y))
          (format t "~A | " (aref board x y))))
    (format t "~%")))
