
(defun xy-shared (x y)
  (+ x (* (- x 1) y)))

(defun xz-shared (x z)
  (+ x (* (- x 1) z)))

(defun yz-shared (y z)
  (+ z (* (- z 1) y)))

(defun f (x y z)
  (let* ((boxes (* z (* x y)))
         (shared-x-y (* 2 (xy-shared x y)))
         (shared-x-z (* 2 (xz-shared x z)))
         (shared-y-z (* 2 (yz-shared y z)))
         (total-shared (+ (+ shared-x-y shared-x-z) shared-y-z))
         (total-edges (* boxes 12))
         (edges (- total-edges total-shared)))
    edges))

(defun outer (x y z)
  (let ((outx (* 2 (+ x y)))
        (outy (* 2 (+ y z)))
        (outz (* 2 (+ z z))))
    (+ outz (+ outx outy))))

(defun f (x y z)
  (+ (* x (1+ y) (1+ z))
     (display (* x (1+ y) (1+ z)))
     (* (1+ x ) y (1+ z))
     (* (1+ x) (1+ y) z)))
