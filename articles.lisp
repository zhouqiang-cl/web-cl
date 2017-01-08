(in-package :web-cl)
(defun post-article ()
    (let ((title (post-parameter "title"))
            (content (post-parameter "content"))
            (articleid (genitemid)))
        (progn (save-article* articleid :title title :content content)
            (format nil 
                (encode-json-plist-to-string 
                    (list "id" articleid "url" (concatenate 'string "/blog/articles/" articleid)))))))


(defun get-article (articleid)
    (progn
        (setf (content-type*) "application/json")
        (increase-view-times* articleid)
        (multiple-value-bind (title content views) (get-article* articleid)
            (format nil 
                (encode-json-plist-to-string
                    (list "title" title "content" content "views" views))))))

(defun get-articles ()
    (progn
        (setf (content-type*) "application/json")
        (format nil
            (encode-json-to-string 
                (loop for item in (get-articles*)
                    collect (list (cons "id" (car item))
                                (cons "title" (cadr item))
                                (cons "url" (concatenate 'string "/blog/articles/" (car item)))))))))


(defun handler-articles ()
    (let ((articleid (car (last (split-sequence:split-sequence #\/ (string-right-trim "/" (request-uri*)))))))
        (if (string= articleid "articles")
            (get-articles)
            (get-article articleid))))

(defun put-article ()
    (let ((title (post-parameter "title"))
            (content (post-parameter "content"))
            (articleid (car (last (split-sequence:split-sequence #\/ (request-uri*))))))
        (progn (save-article* articleid :title title :content content)
            (format nil 
                (encode-json-plist-to-string 
                    (list "id" articleid "url" (concatenate 'string "/blog/articles/" articleid)))))))