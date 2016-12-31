(defun dispatch (dispatch-table)
    (setf *dispatch-table* 
        (mapcar (lambda (args) 
                    (apply 'create-prefix-dispatcher args)) dispatch-table)))

(defun rander (path)
    (handle-static-file path "text/html; charset=utf-8"))

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

(defun start-web () (start (make-instance 'easy-acceptor :port 8080)))