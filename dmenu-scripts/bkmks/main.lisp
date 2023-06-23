;#!/home/belajaakacija/.local/bin/sbcl --script

;;;; Port of the bkmks dmenu script from the suckless website, with my own twist.
;;;; Author: belaja-akacija
;;;; V.0.5

;;; TODO
;;; - Fix the need to put double quotes for certain links, when adding new entries
;;; - Finish the rest of the cases
;;; ✓ create yad dialog box for the (show-usage) output
;;; - add delete entry function

;(load "~/quicklisp/setup.lisp")
;(ql:quickload "cl-ppcre")

(defparameter *browser* "firefox")
(defparameter *url-file-path* #P "~/Documents/.bkmks/")
(defparameter *url-file-name* "urls")
(defparameter *url-full-path* (merge-pathnames *url-file-path* (pathname *url-file-name*)))
;(defparameter *args* sb-ext:*posix-argv*)
;(defparameter *first-arg* (string-downcase (nth 1 *args*)))

(defun show-usage ()
  (show-dialog (format nil "
  bkms: unix bookmark management that sucks less. Lisp edition!
  usage:
       bkmks help
         show this help message
       bkmks add <url>
         add a new bookmark
       bkmks ls
         show all bookmarks

    Configuration is done by directly editing the script.

    If you would prefer to have your bookmarks stored in an alternate locatation, there are also variables that can be changed for that. The default is /home/user/.bkmks/urls~%")))

(defun append->file (url desc)
  (with-open-file (output *url-full-path* :direction :output
                          :if-exists :append :if-does-not-exist :create)
    (format output "~A | ~A~%" url desc)))

(defun bkmks-add ()
  (let ((desc ""))
    (if (null (nth 2 sb-ext:*posix-argv*))
        (show-dialog (format nil "Error: url must be provided.~%~%") :justify "center")
        (progn
          (setq desc (uiop:run-program `("dmenu" "-l" "6" "-p" "Description: ") :output :string))
          (print desc)
          (append->file (nth 2 sb-ext:*posix-argv*) (string-trim '(#\NewLine) desc))))))

(defun bkmks-display ()
  ;; This is currently seeming quite messy and bulky
  (bkmks-check)
  (let ((bkmks-length  (string-trim `(#\NewLine) (uiop:run-program `("wc" "-l")
                                                                  :input *url-full-path*
                                                                  :output :string)))
        (raw-entry "")
        (filtered-entry ""))
    (setq raw-entry (uiop:run-program `("dmenu" "-l", bkmks-length)
                                      :input *url-full-path*
                                      :output :string))
    (setq filtered-entry (cl-ppcre:scan-to-strings ".\+\(?=\\|\)" (string-trim '(#\NewLine) raw-entry)))
    (uiop:run-program `(,*browser* ,filtered-entry))))

(defun bkmks-check ()
  (cond ((null (probe-file *url-full-path*))
         (show-dialog (format nil "Error: No bookmarks found to display. Try adding some!~%~%")))
        ((null (directory *url-file-path*))
         (uiop:run-program `("mkdir" "-v", (directory-namestring *url-file-path*))))
        (t (format nil "Everything OK."))))

(defun show-dialog (dialog &key (justify "left"))
  (let* ((justification (format nil "--justify=~A" justify))
        (dialog-width (length dialog))
        (dialog-height (length (cl-ppcre:split "\\n" dialog)))
        (geometry (format nil "--geometry=~Ax~A+550+300" dialog-width (* 32 dialog-height))))
    (uiop:run-program `("yad" "--text-info" "--wrap" "--margins=20" ,geometry ,justification "--fore=#f2e5bc" "--back=#32302f")
                     :input
                     (uiop:process-info-output
                       (uiop:launch-program `("echo" ,dialog) :output :stream))
                     :output :string)))

(defun main ()
  (cond ((not (null (find (nth 1 sb-ext:*posix-argv*) '("add" "a") :test #'string-equal)))
         (bkmks-add))
        ((not (null (find (nth 1 sb-ext:*posix-argv*) '("help" "h") :test #'string-equal)))
         (show-usage))
        ((not (null (find (nth 1 sb-ext:*posix-argv*) '("nil" "ls") :test #'string-equal)))
         (bkmks-display))
        ;((string-equal "test" *first-arg*)
         ;(show-dialog (format nil "Error!") :justify "center"))
        (t (show-usage))))

;(main)
