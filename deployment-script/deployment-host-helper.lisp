;;;; Get all the necessary packages and config files from the host machine to
;;;; transfer over to a new computer. Assumes Arch install.

(defun get-package-list ()
  (shell "pacman -Qneq > pkgs.pacman.tmp")
  (shell "pacman -Qmeq > pkgs.aur.tmp")
  (values #P"pkgs.pacman.tmp"
          #P"pkgs.aur.tmp")) ;; return the name of the file to use as param in the other functions

(defparameter *pacman* (car (multiple-value-list (get-package-list))))

(defparameter *aur* (cadr (multiple-value-list (get-package-list))))

(defun file->list (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

;; test to read a file and recurse through the list
(defun line-by-line (filename)
  (let* ((file-list (file->list filename)))
    (labels ((lbl-helper (list)
               (if (null list) '()
                   (progn
                     (print (car list))
                     (lbl-helper (cdr list))))))
      (lbl-helper file-list))))

(defun concat-all-packages (filename) 
  "concatenates all the packages in a file based on where they are from (aur or normal repos)"
  (let* ((file-list (file->list filename))
         (package-list ""))
    (labels ((helper (list)
               (if (null list) '()
                   (progn
                     (setq package-list (string-concat package-list " " (car list)))
                     (helper (cdr list))))))
      (helper file-list))
    (if (equal filename *aur*)
        (string-concat "aur -S" package-list)
        (string-concat "sudo pacman -S" package-list))))
