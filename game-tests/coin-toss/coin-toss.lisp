(defun toss-coin ()
  "generate a random number between 0 and 1, that is, heads or tails"
  (let ((number (random 2 (make-random-state t))))
    (if (= number 0) 
        "heads"
        "tails")))

(defun prompt ()
  "get user input, heads or tails. If invalid, prompt again."
  (format t "Enter heads or tails: ")
  (let ((guess (string-downcase (read-line))))
    (if (or (string= guess "heads")
            (string= guess "tails"))
        guess
        (prompt))))

(defun game ()
  "Actual game loop"
  (if (string= (prompt) (toss-coin))
      (format t "You win!~%")
      (format t "You lose!~%"))
  (game))
