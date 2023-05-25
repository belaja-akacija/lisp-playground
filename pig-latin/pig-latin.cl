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


(ql:quickload "cl-ppcre")

(defun vowelp (chr)
  (cond 
    ((not (characterp chr))
     (error "not character"))
    ((not (alpha-char-p chr))
     (error "not an alpha char"))
    ((string-equal (car (multiple-value-list (cl-ppcre:scan-to-strings "[aeiouAEIOU]" (string chr)))) (string chr))
     t)
    ((string-equal (car (multiple-value-list (cl-ppcre:scan-to-strings "{^[aeiouAEIOU]}" (string chr)))) (string chr))
     nil)))

(defun string->pig-latin (str)
  "Returns a string in pig latin"
  (let ((processed-string "")
        (word (cl-ppcre:split "\\s+" str)))
    (labels ((string-processing-helper (lst str)
               (if (null lst) nil
                   (let* ((popped-word (car lst))
                          (first-letter (char popped-word 0))
                          (length-of-word (1- (length popped-word)))
                          (consonant-cluster 
                            (car (nreverse
                                   (loop for x from 0 to length-of-word
                                         until (vowelp (char popped-word x))
                                         collect x)))))
                     (if (vowelp first-letter)
                         (progn
                           (setf processed-string 
                                 (string-concat 
                                   processed-string 
                                   popped-word "way "))
                           (string-processing-helper (cdr lst) str))
                         (progn
                           (setf processed-string 
                                 (string-concat 
                                   processed-string 
                                   (subseq popped-word (1+ consonant-cluster) (length popped-word))
                                   (subseq popped-word 0 (1+ consonant-cluster)) 
                                   "ay "))
                           (string-processing-helper (cdr lst) str)))))
               processed-string)); return string
      (string-processing-helper word str))))

;; unneccesary function, but good one to keep 
(defun string->list (str) 
  "Converts the string into a list of chars"
  (defun string-helper (str counter len)
    (if (> counter len) '()
        (cons (char str counter) (string-helper str (+ counter 1) len))))
  (if (null str) '()
      (string-helper str 0 (- (length str) 1))))

