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
