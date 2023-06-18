;;;; generate a password, given [a-zA-Z] and special chars

(load #P "~/quicklisp/setup.lisp")
(require "cl-ppcre")
;(ql:quickload "cl-ppcre")
;(asdf:load-system 'cl-ppcre)

(defparameter *lowercase* (cl-ppcre:split "" "abcdefghijklmnopqrstuvwxyz"))
(defparameter *uppercase* (cl-ppcre:split "" "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
(defparameter *special* (cl-ppcre:split "" "!@#$%^&*()[]"))

(defun random-list (lst)
  (random (length lst) (make-random-state t)))

(defun list->string (lst)
  (let ((str ""))
    (labels ((helper (lst)
               (if (null lst)
                   nil
                   (progn
                     (setf str (string-concat str (car lst)))
                     (helper (cdr lst))))))
      (helper lst)
      str)))

(defun generate-password (lower upper spec)
  (let ((random-list '())
        (actual-list '()))
    (loop for x from 0 to 32
          do (progn
               (push (nth (random-list lower) lower) random-list )
               (push (nth (random-list spec) spec) random-list )
               (push (nth (random-list upper) upper) random-list)))
    (loop for x from 0 to 32
          do (push (nth (random-list random-list) random-list) actual-list))
    actual-list))

(defun generate-password-string ()
  (list->string (generate-password *lowercase* *uppercase* *special*)))

(format t "~A~%" (generate-password-string))
