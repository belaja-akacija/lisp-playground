;; a global var in lisp is called a _top-level function_.
;; to define one, use `defparameter`
;; global vars are usually surrounded by "earmuffs" (**) as convention to distinguish 
;; that they are global

(defparameter *small* 1)
(defparameter *big* 100)

;; when setting the global var using defparameter, any previous value stored will be overwritten
;; to avoid this, you can use "defvar" e.g.
;; (defvar *small* 2)
;; *SMALL*
;; > *small*
;; 2
;; (defvar *small* 3)
;; *SMALL*
;; > *small*
;; 2

;; ash performs the arithmetic shift operation on the binary representation of integer.
;; in this this function, we are effectively saying:
;; 1. take the sum of *small* and *big*
;; 2. apply ash to the sum and shift down by -1 (which halves the value) (e.g. (ash 10 -1) --> 5)

(defun guess-my-number ()
  (ash (+ *small* *big*) -1))

;; use setf to change the value of the global variables if bigger or smaller by -1, since we can deduce that the limits are at LEAST -1 or +1 away from the number 

(defun smaller ()
  (setf *big* (1- (guess-my-number)))
  (guess-my-number))

(defun bigger ()
  (setf *small* (1+ (guess-my-number)))
  (guess-my-number))

;; start over function. Resets the vars to default values and calls guess-my-num function

(defun start-over ()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess-my-number))

;; defining a local function using flet
;; structure:
;; (flet ((function_name (arguments)
;;           ...function body...))
;; ...body...)

(flet ((func-a (n)
               (+ n 10)))
  (func-a 10))

;; you can also define more than one function   
(flet ((f (n)
          (+ n 10))
       (g (n)
          (- n 10)))
  (g (f 3)))

;; to make function names available in other defined functions,
;; we can use the labels command. The structure is identical to
;; the flet command

(labels ((a (n)
            (+ n 5))
         (b (n)
            (+ (a n) 6))) ;; calling a previously defined local function 
  (b 10))
