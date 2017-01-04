(defun post-article ()
    (let ((title (post-parameter "title"))
            (content (post-parameter "content"))
            (articleid (genitemid)))
        (progn (save-article-to-db articleid title content)
            (format nil 
                (unescape_url
                    (encode-json-plist-to-string 
                        (list "id" articleid "url" (princ (concatenate 'string "/blog/articles/" articleid)))))))))


(defun get-article (articleid)
        (multiple-value-bind (title content) (get-article-from-db articleid)
            (format nil 
                (encode-json-plist-to-string
                    (list "title" (car title) "content" (car content))))))

(defun get-articles ()
    (format nil
        (encode-json-to-string (get-articles-from-db))))


(defun handler-articles ()
    (let ((articleid (car (last (split-sequence:split-sequence #\/ (request-uri*))))))
        (if (string= articleid "articles")
            (get-articles)
            (get-article articleid))))

(defun put-article ()
    (let ((title (post-parameter "title"))
            (content (post-parameter "content"))
            (articleid (car (last (split-sequence:split-sequence #\/ (request-uri*))))))
        (progn (save-article-to-db articleid title content)
            (format nil 
                (unescape_url
                    (encode-json-plist-to-string 
                        (list "id" articleid "url" (princ (concatenate 'string "/blog/articles/" articleid)))))))))