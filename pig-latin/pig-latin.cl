;; for words that start with consonants, all letters before the initial vowel are placed at the end of the word sequence. Then, "ay" is added. EX: "pig" -- "igpay" "banana" -- "ananabay"

;; when words start with consonant clusters, the whole sound is added to the end. EX: "friends" -- "iendesfray" "string" -- "ingstray"

;; for words that start with a vowel, just add "way" to the end.


;; write a function that can tell the difference between a consonant and vowel
;; iterate through the word until the first vowel is found 
;; pop the consonant(s) off the beginning of the word
;; store the consonant(s) in a variable. (or a list)
;; apply "ay" to the consonant var
;; append the consonant var to the string.


;; store each word of the sentence in a list (a word is space delimited)
;; car each word in a for loop and apply the above logic to it
;; append the word in a new list
;; repeat until reach end of list
;; nreverse the new list


(require "cl-ppcre")


;;; working functions

(defun vowel-or-cons? (str)
  (let ((some-char (char str 0)))
    (cond
    ((not (characterp some-char))
           'not-char)
    ((not (alpha-char-p some-char))
     'not-letter)
    ((string-equal (car (multiple-value-list (cl-ppcre:scan-to-strings "[aeiouAEIOU]" str))) 
                   some-char)
          :vowel)
    ((string-equal (car (multiple-value-list (cl-ppcre:scan-to-strings "[^{aeiouAEIOU}]" str))) 
                   some-char)
          :consonant))))


;;; in development 

;; make a string into a list, with the structure:
;; '((#\w #\o #\r #\d) #\Space (#\w #\o #\r #\d))
;; what are the conditions for the loop do I have to make in order for the list be properly nested?
;;;; 1. how do I nest a list?

;;;; perhaps I need two loops nested inside each other?
;;;; That would work, but feels wrong to do
(defun string->list (str)
  (let ((list-string '()))
    (loop for letter from 0 to (- (length str) 1)
          if (equal (char str letter)  #\Space)
          do (push (char str letter) list-string)
          else 
          do (push (list (char str letter)) (car list-string )))
    (nreverse list-string)))

;; process the string into pig latin. 
(defun str-process (str)
  (let ((letter (string (car (string->list str))))
        (popped-list (string->list str)))
    (cond 
      ((equal 
             (vowel-or-cons? letter)
             :consonant)
;; collects the first letters of a word that are consonants into a list
  (loop for x in (string->list str)
      while (not (equal (vowel-or-cons? (string x)) :vowel))
      collect (string x)
      do (setf popped-list (cdr popped-list))
      do (print popped-list))
       )
      ((equal 
         (vowel-or-cons? letter)
         :vowel)
       (string-concat str "way"))
    )
    ))

;; test function to make a list into a string. May not be neccessary
(defun list->string (lst)
  (let ((some-var '()))
    (loop for x from )))


;; test the loop
;; expected behaviour: take the first letters of the string that are consonants and append them to a list
;; then all the rest of the values, append them into another list. (or in the same list, just in front of the consonant values that were popped off in the beginning) 
;; this may not be possible with this method. Consider other solutions

(let ((some-list '()))
  (loop named outer 
        for x in (string->list "hhhello world")
        do
        (progn 
          (loop named inner
                while (not (equal (vowel-or-cons? (string x)) :vowel))
                collect x into y
                )
          collect x)))

;when (equal (vowel-or-cons? (string x)) :vowel)
;collect x into y))
