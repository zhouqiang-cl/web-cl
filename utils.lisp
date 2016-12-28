(defun dispatch (dispatch-table)
    (setf hunchentoot:*dispatch-table* 
        (mapcar (lambda (args) 
                    (apply 'hunchentoot:create-prefix-dispatcher args)) dispatch-table)))

(defun start-web () (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080)))