(require "~/quicklisp/asdf.lisp")

(defun check-network ()
  (format t "Checking network status...~%")
  (let ((exit-code (pop (cddr (multiple-value-list (uiop:run-program '("ping" "-c 1" "-W 5" "gnu.org") :error-output :string :ignore-error-status t))))))
    (if (zerop exit-code)
      (princ 'connected)
      (on-fail))))


(defun on-fail ()
  (format t "~tNetwork check failed.~%Do you wish to open nmtui? [Y/n]: ")
  (let ((input (read-line)))
    (cond 
      ((string-equal "" input)
       (uiop:run-program '("st" "nmtui")))
      (( or (equal #\n (char input 0)) (equal #\N (char input 0)))
       'exit)
      (( or (equal #\y (char input 0)) (equal #\Y (char input 0) ))
       (uiop:run-program '("st" "nmtui")))
      (t (format t "~%Invalid command. Please try again.~%~%")
         (on-fail)))))

(defun show-pass ()
(let ((exit-code (pop (cddr 
       (multiple-value-list 
         (uiop:run-program 
           '("nmcli" "device" "wifi" "show-password") 
           :output t :ignore-error-status t))))))
         (if (zerop exit-code)
           'success
           (on-fail))))
