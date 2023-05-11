;; This is a rewrite attempt at my Scratchpad script, which was originally written in Bash

(ql:quickload "local-time")
(ql:quickload "cl-ppcre")
(defparameter *yesterday* (local-time:format-timestring nil (local-time:timestamp- (local-time:now) 1 :day) 
                                                        :format '(:day "-" :month "-" :year)))

(defparameter *date* (local-time:format-timestring nil (local-time:now) 
                                                   :format '(:day "-" :month "-" :year)))

(defparameter *temp* (make-pathname 
                       :type "tmp" 
                       :defaults 
                       (merge-pathnames #p"/tmp/" (pathname *yesterday*))))

(defparameter *perm* #p"~/.local/share/scratchpad/data")

(defparameter *curr-month* (local-time:format-timestring nil (local-time:now) 
                                                         :format '(:short-month)))

(defparameter *curr-year* (local-time:format-timestring nil (local-time:now) 
                                                        :format '(:year)))

(defparameter *dir* (make-pathname 
                      :directory `(:relative "~" ".local" "share" "scratchpad" ,*curr-year* ,*curr-month*)))

;; https://www.phind.com/search?cache=8c7694e3-03fc-42c7-8423-e7466f562bac&init=true  -- use 'gx' to open the link
;; Read the file line by line.
;; Check if the line matches the given regex.
;; If the line matches, append it to a list.

(defun read-lines-matching-regex (filename regex)
  (let ((lines-matching '()))
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line do
          (when (cl-ppcre:scan-to-strings regex line) ;; when returns not NIL, push the line into a list
            (push line lines-matching))))
  (nreverse lines-matching)))

;; append the lines in a list to a file
(defun append-list->file (filename list)
  (with-open-file (output filename :direction :output :if-exists :append :if-does-not-exist :create)
    (dolist (line list)
      (format output "~A~%" line))))

