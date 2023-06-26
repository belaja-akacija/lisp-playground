;;;; deploy on a directory that has a bunch of wallpapers and change the
;;;; current wallpaper with a random one using `feh`
;;;; Useful in .xinitrc or as a cronjob

(defparameter *home* (namestring (user-homedir-pathname)))
(defparameter *wallpapers* (cl-fad:list-directory (pathname (format nil "~awallpapers/" *home*))))

(defun random-from-range (start end)
  "generate a random number in a range"
  (+ start (random (+ 1 (- end start)) (make-random-state t))))

(defun wallpaper-changer ()
  "change to a random wallpaper using feh"
  (if (null *wallpapers*)
      nil
  (let* ((random-index (random-from-range 0 (1- (length *wallpapers*))))
         (random-wallpaper (namestring (nth random-index *wallpapers*)))) ; lookup namestring for future reference. I keep forgetting what it does until I need it again.
    (uiop:run-program `("feh" "-Z" "--bg-center" ,random-wallpaper)))))
