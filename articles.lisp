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
    (get-article-from-db articleid))