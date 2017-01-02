; (defun auth () )
(defmacro admin (func) 
    `(if (auth) 
        ,func
        (redirect-to-login)))