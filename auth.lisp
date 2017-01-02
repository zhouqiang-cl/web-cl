(defun auth () )
(defun get-username ())
(defun set-username ())
(defmacro admin (func) 
    `(if (auth) 
        ,func
        (redirect-to-login)))