(defun post-article ()
    (let ((title (post-parameter "title"))
            (content (post-parameter "content"))
            (articleid (genitemid)))
        (progn (save-article-to-db articleid title content)
            (format nil 
                (unescape_url
                    (encode-json-plist-to-string 
                        (list "id" articleid "url" (princ (concatenate 'string "/blog/articles/" articleid)))))))))

(defun get-article ()
    (let ((articleid (car (last (split-sequence:split-sequence #\/ (request-uri*))))))
        (progn
            (multiple-value-setq (title content) (get-article-from-db articleid)))
            (format nil 
                (encode-json-plist-to-string
                    (list "title" (car title) "content" (car content))))))

(defun put-article ()
    (let ((title (post-parameter "title"))
            (content (post-parameter "content"))
            (articleid (car (last (split-sequence:split-sequence #\/ (request-uri*))))))
        (progn (save-article-to-db articleid title content)
            (format nil 
                (unescape_url
                    (encode-json-plist-to-string 
                        (list "id" articleid "url" (princ (concatenate 'string "/blog/articles/" articleid)))))))))