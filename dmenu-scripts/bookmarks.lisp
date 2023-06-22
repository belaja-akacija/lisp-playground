#!/home/belajaakacija/.local/bin/sbcl --script

;;;; TODO
;;;; - Fix the need to put double quotes for certain links, when adding new entries
;;;; - Finish the rest of the cases

(load "~/quicklisp/setup.lisp")
(ql:quickload "cl-ppcre")

(defparameter *url-file-path* #P "~/Documents/.bmks/")
(defparameter *url-file-name* "urls")
(defparameter *first-arg* (string-downcase (car uiop:*command-line-arguments*)))

(defun show-usage ()
  (format t "bkms: unix bookmark management that sucks less. Lisp edition!"))

(defun append->file (url desc)
  (with-open-file (output (merge-pathnames *url-file-path* (pathname *url-file-name*)) :direction :output
                          :if-exists :append :if-does-not-exist :create)
    (format output "~A | ~A~%" url desc)))

(defun bmks-add ()
  (let ((desc ""))
    (if (null (cadr uiop:*command-line-arguments*))
        (format t "Error: url must be provided.~%~%")
        (progn
          (setq desc (uiop:run-program `("dmenu" "-l" "6" "-p" "Description: ") :output :string))
          (print desc)
          (append->file (cadr uiop:*command-line-arguments*) (string-trim '(#\NewLine) desc))
          ))))

(defun bmks-display ()
  ;; This is currently seeming quite messy and bulky
  (let ((bmks-length  (string-trim `(#\NewLine) (uiop:run-program `("wc" "-l")
                                                                  :input #P "/home/belajaakacija/Documents/.bmks/urls"
                                                                  :output :string)))
        (raw-entry "")
        (filtered-entry ""))
    (setq raw-entry (uiop:run-program `("dmenu" "-l", bmks-length)
                                      :input #P "/home/belajaakacija/Documents/.bmks/urls"
                                      :output :string))
    (setq filtered-entry (cl-ppcre:scan-to-strings ".\+\(?=\\|\)" (string-trim '(#\NewLine) raw-entry)))
    (uiop:run-program `("firefox", filtered-entry))))

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
         (show-usage))
        ((string-equal "nil" *first-arg*)
         (bmks-display))))
(main)
