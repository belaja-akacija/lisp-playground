;;;; generate a password, given [a-zA-Z] and special chars

(load #P "~/quicklisp/setup.lisp")
(require "cl-ppcre")
;(ql:quickload "cl-ppcre")
;(asdf:load-system 'cl-ppcre)

(defparameter *lowercase* (cl-ppcre:split "" "abcdefghijklmnopqrstuvwxyz"))
(defparameter *uppercase* (cl-ppcre:split "" "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
(defparameter *logograms* (cl-ppcre:split "" "#$%&@^`~"))
(defparameter *punctuation* (cl-ppcre:split "" ".,:;"))
(defparameter *math-symbols* (cl-ppcre:split "" "<>*+!?="))

(defun random-list (lst)
  (random (length lst) (make-random-state t)))

(defun list->string (lst)
  "generate a string from a list"
  (let ((str ""))
    (labels ((helper (lst)
               (if (null lst)
                   nil
                   (progn
                     (setf str (string-concat str
                                              (if (numberp (car lst))
                                                  (string (digit-char (car lst)))
                                                  (string (car lst)))))
                     (helper (cdr lst))))))
      (helper lst)
      str)))

;; TODO maybe make a &rest so that each element is optional?
(defun generate-password (lower upper logo &key (length 32))
  (let ((random-list '())
        (actual-list '()))
    ;; figure out how to test every optional argument
    ;; test if null. If t, set it to ""
    ;(if (null all-optionals) (setf the-optional "")
        ;(do-nothing))
    (loop for x from 0 to length
          do (progn
               (push (nth (random-list lower) lower) random-list )
               (push (nth (random-list logo) logo) random-list )
               (push (nth (random-list upper) upper) random-list)))
    (loop for x from 0 to length
          do (push (nth (random-list random-list) random-list) actual-list))
    actual-list))

(defun generate-password-string ()
  (list->string (generate-password *lowercase* *uppercase* *logograms*)))

(format t "~A~%" (generate-password-string))
