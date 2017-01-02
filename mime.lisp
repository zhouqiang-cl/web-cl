(setf mime-table '(
    ("css" "text/css")
    ("js" "text/js")
    ("default" "text/html; charset=utf-8")
    ))

(defun init-mime-table (table-content mime-table)
    (mapcar (lambda (args) 
        (setf (gethash  (intern (string-upcase (car args))) mime-table) (cadr args))) table-content))

(defun get-mime-type (mime)
    (let ((type (gethash (intern (string-upcase mime)) *mime-table*)))
        (if type
            type
            (gethash (intern (string-upcase "default")) *mime-table*))))

(defun get-file-mime-type (filename) 
    (get-mime-type (car (reverse (split-sequence:split-sequence #\. filename)))))