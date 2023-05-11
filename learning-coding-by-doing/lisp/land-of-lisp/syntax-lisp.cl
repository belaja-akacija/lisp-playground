;; Cons cells
;; Lists in lisp are held together with cons cells. 

;; (data . data)
;; it is made of two links pointing to other things.  

;; if we make a list '(1 2 3), for instance, what is happening is actually this:
;; (1 . --> )
;;       (2 . -->)
;;             (3 . nil)
;; that is, it creates a linked list, where the first value is a pointer to a piece of data and the second is a pointer to another cons cell containing the same structure, until the final cell, where the second value holds 'nil to terminate the list

;; list functions
;; three most basic functions: cons, car, and cdr

;; cons:
;; if you want to link any two pieces of data together in your program (regardless of type) you can use cons.

(cons 'lemon 'chicken)
(cons (expt 2 10) '("hi"))

;; cons returns a single object, the cons cell, represented by parens and a dot between the two connected items.
;; cons are not a regular list, it just links two items together

;; consider the following:
(cons 'lemon 'nil)
;; the output is (LEMON)
;; nil is a special symbol that is used to terminate a list.
;; the empty list can be used interchangebly with the 'nil symbol.

(cons 'lemon (cons 'chicken 'nil))
;; > (LEMON CHICKEN)
;; same thing as doing '(lemon chicken)


;; car and cdr functions:
;; car -- getting the thing out of the first slot of a cell
(car '(1 2 3)) ;; > 1

;; cdr -- grab the value of the second slot, or the remainder of the list
(cdr '(1 2 3)) ;; > (2 3)

;; you can string together car and cdr into new functions like cadr, cdar, or cadadr. This lets you succinctly extract specific pieces of data out of complex lists.
;; Entering cadr is the same as using car and cdr together -- returns the second item of the list
(cadr '(1 2 3)) ;; > 2


;; the list function:
;; does the dirty work of creating all the cons cells and builds our list all at once:
(list 'pork 'beef 'chicken) ;; (PORK BEEF CHICKEN)


;; Nested lists:
;; lists can contain other lists. 
'(cat (duck bat) ant) ;; list contains three items, the second item is a list itself.
(cons 'cat (cons (cons 'duck (cons 'bat 'nil) (cons 'ant 'nil))) ;; same thing as above

