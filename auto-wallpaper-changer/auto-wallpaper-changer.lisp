;;;; deploy on a directory that has a bunch of wallpapers and change the
;;;; current wallpaper with a random one using `feh`

(load #P"~/quicklisp/asdf.lisp")

(defparameter *wallpapers* (directory "~/Pictures/Wallpapers/*"))

(defun random-from-range (start end)
  "generate a random number in a range"
  (+ start (random (+ 1 (- end start)) (make-random-state t)))) ; look up later why you have to add (make-random-state) to make this work in compiled files

(defun indexer (index list)
  "go to a particular index in list and pull it out"
  (labels ((indexer-helper (iterator index list)
             (if (= iterator index) (car list) 
                 (indexer-helper (1+ iterator) index (cdr list)))))
    (indexer-helper 0 index list)))

(defun wallpaper-changer ()
  "change to a random wallpaper using feh"
  (let* ((random-index (random-from-range 0 (1- (length *wallpapers*))))
         (random-wallpaper (namestring (indexer random-index *wallpapers*))))
    (uiop:run-program `("feh" "-z" "-Z" "--bg-center" ,random-wallpaper))))
