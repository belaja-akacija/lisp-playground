(defun main ()
  (cond
        ((not (null (find (nth 1 sb-ext:*posix-argv*) '("w" "p" "wifi" "pass") :test #'string-equal)))
         (show-pass))
        (t (network-check-helper))))
