(defun same-case (a b)
  "Check if two characters are the same case (upper or lower)"
  (if (or (null a) (null b)) -1
  (let ((letter-a (char a 0))
        (letter-b (char b 0)))
  (cond 
    ((and (alpha-char-p letter-a) (alpha-char-p letter-b)) ; if both alpha-chars
     (cond 
       ((and (upper-case-p letter-a) (upper-case-p letter-b)) ; if both uppercase
        1)
       ((and (lower-case-p letter-a) (lower-case-p letter-b))
        1)
       (t 0)))
    (t -1)))))
