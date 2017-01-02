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
    (let* ((articleid (car (reverse (split-sequence:split-sequence #\/ (request-uri*))))) (multiple-value-setq (title content) (get-article-from-db articleid)))
        (format nil 
            (encode-json-plist-to-string
                (list "title" title "content" content)))))