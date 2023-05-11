(defun is-square? (n)
  (cond
    ((equal n 0)
     t)
    ((null n)
     nil)
    ((equal n -1)
     nil)
    ((equal (rem (sqrt n) 1) 0)
     t)))

(defun potatoes (p0 w0 p1)
  (let ((wwi (/ w0 (/ p0 100)))
        (wwf (/ w0 (/ p1 100))))
    (* wwf (/ p1 100))))

;; percentage_water = (tot_weight_initial/water_weight_init)*100
;; pw = (tw/wwi) * 100
;; wwi = tw/(pw/100)
;; wwi * (pw/100) = tw

0 = wwi * (98/100) - 50
0 = wwi * (99/100) - 100
wwi * (98/100) -50 = wwi * (99/100) -100
wwi * (pw_f) = wwi * (pw_i) - 50
pw_f = (wwi * (pw_i) - 50)/wwi
