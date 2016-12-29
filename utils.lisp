(defun dispatch (dispatch-table)
    (setf *dispatch-table* 
        (mapcar (lambda (args) 
                    (apply 'create-prefix-dispatcher args)) dispatch-table)))

(defun rander (path)
    (handle-static-file path "text/html; charset=utf-8"))

(defun start-web () (start (make-instance 'easy-acceptor :port 8080)))