(defun dispatch (dispatch-table)
    (setf *dispatch-table* 
        (mapcar (lambda (args) 
                    (apply 'create-prefix-dispatcher args)) dispatch-table)))

(defun rander (path)
    (let ((mime-type (get-file-mime-type path)))
         (handle-static-file path mime-type)))

(defun serve-static-dir ()
    (let ((path (string-left-trim "/" (request-uri*)))) (rander path)))

(defun uuid-to-string (uuid)
    (string-downcase (print-bytes nil uuid)))

(defun genitemid ()  (uuid-to-string (make-v4-uuid)))

(defun save-article (itemid title content)
    (progn (store-to-db itemid title content)
        (format nil 
            (unescape_url
                (encode-json-plist-to-string 
                    (list "id" itemid "url" (princ (concatenate 'string "/blog/items/" itemid))))))))

(defun store-to-db (itemid title content)
    (progn (db.use "blog")
        (db.insert itemid (kv (kv "title" title) (kv "content" content)))))

(defun unescape_url (s) (remove #\\ s))

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
(defun start-web () (start (make-instance 'easy-acceptor :port 8080)))