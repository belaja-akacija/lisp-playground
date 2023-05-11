#!/usr/bin/sbcl --script
;;;; This should open a file using the appropriate program from the shell, depending on the extension

;;; provide the script the filename from stdin as argument
;;; split out the name of file and path from the extension
;;; read the extension and determine from a predefined list of programs for which one it should open
;;; then use (ext:shell) to execute the command on the file

;;; planned programs: vlc, zathura, gifview (this is an alias), nvim

;; figure out how to read the input stream from shell


(require "~/quicklisp/asdf.lisp")

;; reading cmd line args
(dolist (element uiop:*command-line-arguments*)
  (uiop:writeln element))
  ;(write-line element))

;(princ (input-stream-p *standard-input*))
