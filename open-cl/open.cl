#!/usr/bin/sbcl --script
;;;; This should open a file using the appropriate program from the shell, depending on the extension

;;; provide the script the filename from stdin as argument
;;; split out the name of file and path from the extension
;;; read the extension and determine from a predefined list of programs for which one it should open
;;; then use (ext:shell) to execute the command on the file

;;; planned programs: vlc, zathura, gifview (this is an alias), nvim

;; figure out how to read the input stream from shell


(require "~/quicklisp/asdf.lisp")
(require "cl-ppcre")

;; reading cmd line args
(dolist (element uiop:*command-line-arguments*)
  (uiop:writeln element))
  ;(write-line element))

;(princ (input-stream-p *standard-input*))

;; testing conditionals
;; if some-file is pdf, then run zathura
(defparameter *some-file* "~/Documents/Books/sicp.pdf")
(if (string= (ppcre:scan-to-strings ".+pdf" *some-file*) *some-file*)
    (uiop:run-program `("zathura" ,*some-file*))
    'not-true)

(if (string= "f" "t")
    'true
    'false)
