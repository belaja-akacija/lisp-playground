;;;; could be useful later to make interactive scripts

(defparameter *toggle-on* "")
(defparameter *toggle-off* "")

(defun toggle-test (toggle)
  (let ((toggle-switch 0))
    (if (= toggle 0)
      (progn
        (setf toggle-switch 1)
        (shell "clear")
        (format t "~A~%" *toggle-off*))
      (progn
        (setf toggle-switch 0)
        (shell "clear")
        (format t "~A~%" *toggle-on*)))
  (read-line)
  (toggle-test toggle-switch)))
