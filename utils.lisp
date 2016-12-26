(defmacro dispatch (uri handler)
    `(construct ,handler ,uri))

(defun construct (handler uri)
    (let ((h (make-instance handler)))
        (method-get h)))