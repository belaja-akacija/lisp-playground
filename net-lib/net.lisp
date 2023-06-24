(defun check-network-p ()
  (let ((exit-code (pop (cddr (multiple-value-list (uiop:run-program '("ping" "-c 1" "-W 5" "gnu.org") :error-output :string :ignore-error-status t))))))
    (if (zerop exit-code)
        t ;connected
        nil)))

(defun on-fail ()
  (format t "~%~tNetwork check failed.~%Do you wish to open nmtui? [Y/n]: ")
  (let ((input (string-downcase (read-line))))
    (cond
      ((string-equal "" input)
       (uiop:run-program '("st" "nmtui")))
      ((equal #\n (char input 0))
       input) ; returns the input, so network-check-helper can break out of loop
      ((equal #\y (char input 0))
       (uiop:run-program '("st" "nmtui")))
      (t (format t "~%Invalid command. Please try again.~%")
         (on-fail)))))

(defun network-check-helper ()
  "check network again after opening nmtui on fail"
  (format t "~%Checking network status...~%")
  (if (check-network-p)
      (format t "Connected~%~%")
      (if (string-equal (on-fail) "n") '()
          (network-check-helper))))

(defun show-pass ()
  (let ((exit-code (pop (cddr (multiple-value-list
                                (uiop:run-program
                                  '("nmcli" "device" "wifi" "show-password")
                                  :output t :ignore-error-status t))))))
    (if (zerop exit-code)
        'success
        (on-fail))))
