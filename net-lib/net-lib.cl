(require "~/quicklisp/asdf.lisp")

(defun check-networkp ()
  (format t "Checking network status...~%")
  (let ((exit-code (pop (cddr (multiple-value-list (uiop:run-program '("ping" "-c 1" "-W 5" "gnu.org") :error-output :string :ignore-error-status t))))))
    (if (zerop exit-code)
        t ;connected
        nil)))


;; TODO find out how to update the input variable after the invalid command case
(defun on-fail ()
  (format t "~%~tNetwork check failed.~%Do you wish to open nmtui? [Y/n]: ")
  (let ((input (string-downcase (read-line))))
    (cond 
      ((string-equal "" input)
       (uiop:run-program '("st" "nmtui")))
      ((equal #\n (char input 0))
       '())
      ((equal #\y (char input 0))
       (uiop:run-program '("st" "nmtui")))
      (t (format t "~%Invalid command. Please try again.~%")
         (on-fail)))
    input)) ; returns the input, so network-check-helper can break out of loop

(defun network-check-helper () 
"check network again after opening nmtui on fail"
(if (check-networkp)
    (print 'connected)
    (if (string-equal (on-fail) "n") '()
        (network-check-helper))))

(defun show-pass ()
(let ((exit-code (pop (cddr 
       (multiple-value-list 
         (uiop:run-program 
           '("nmcli" "device" "wifi" "show-password") 
           :output t :ignore-error-status t))))))
         (if (zerop exit-code)
           'success
           (on-fail))))
