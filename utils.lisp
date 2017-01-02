(defun dispatch (dispatch-table)
    (setf *dispatch-table* 
        (mapcar (lambda (args) 
                    (apply 'create-prefix-dispatcher args)) dispatch-table)))

(defun rander (path)
    (let ((mime-type (get-file-mime-type path)))
         (handle-static-file path mime-type)))

(defun uuid-to-string (uuid)
    (string-downcase (print-bytes nil uuid)))

(defun genitemid ()  (uuid-to-string (make-v4-uuid)))

(defun unescape_url (s) (remove #\\ s))

(defun start-web () (start (make-instance 'easy-acceptor :port 8080)))