;#!/bin/clisp
(load "~/quicklisp/setup.lisp")

(defparameter *prefered-launcher* "dmenu")
(defparameter *url-file-path* #P "~/Documents/.bmks/")
(defparameter *url-file-name* "urls")
(defparameter *first-arg* (string-downcase (car ext:*args*)))

(defun show-usage ()
  (format t "bkms: unix bookmark management that sucks less. Lisp edition!"))

  (defun append->file (url desc)
    (with-open-file (output (merge-pathnames *url-file-path* (pathname *url-file-name*)) :direction :output
                            :if-exists :append :if-does-not-exist :create)
      (format output "~A | ~A~%" url desc)))

(defun bmks-add ()
  ;(if (null uiop:*command-line-arguments*)
  (let ((desc ""))
   (if (null (cadr ext:*args*))
       (format t "Error: url must be provided.~%~%")
       (progn
         ;(format t "Description: ")
         (setq desc (uiop:run-program `("dmenu" "-l" "6" "-p" "Description: ") :output :string))
         (print desc)
         (append->file (cadr ext:*args*) (string-trim '(#\NewLine) desc))
         ))))

(defun bmks-check ()
  (cond ((null (probe-file (merge-pathnames *url-file-path* (pathname *url-file-name*))))
         (format t "Error: No bookmarks found to display. Try adding some!~%~%"))
        ((null (probe-directory *url-file-path*))
         (uiop:run-program `("mkdir" "-v", (directory-namestring *url-file-path*))))
        (t (format nil "Everything OK."))))

(defun main ()
  (cond ((string-equal "add" *first-arg*)
         (bmks-add))
        ((not (null (find *first-arg* '("help" "h") :test #'string-equal)))
         (show-usage))))
;; finish the rest of the cases
(main)
