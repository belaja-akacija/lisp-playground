;;;; Take in a title, ingredients list, and method for each recipe
;;;; Then store it in a file with the recipe name


(defun title () 
  (princ "Please enter a title: ")
  (let ((title (read-line)))
    (princ title)))

;; For this function, I want it to be a bit more interactive
;; It should ask for an initial amount of ingredients
;; then loop through and input a measurement amount, type of ingredient for each one
;; then after the last one, ask to confirm the ingredients and give option to add more 
;; make an associated list to store the measurments with the ingredients

(defun ingredients ()
  (princ "How many ingredients does your recipe have? ")
  (let ((ingr '())
        (num-of-ingr (read)))
    (loop for x from 0 to (- num-of-ingr 1)
          do (format t "what is your ~A ingredient? " (+ x 1))
          do (push (read-line) ingr))
    (nreverse ingr)
    ingr))

;; loop over the input until each method has been input and
;; the read-line is an empty string

(defun methods ()
  (print "Enter your steps for the recipe. Type 'done' when you are done.")
  (let ((steps '()))
    (loop while (not (string= (car steps) "done"))
          do (princ "> ")
          do (push (read-line) steps))
    (nreverse steps)
    steps))
