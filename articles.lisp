(in-package :web-cl)
(defun post-article ()
    (let* ((title (post-parameter "title"))
            (content (post-parameter "content"))
            (articleid (genitemid))
            (update-time (get-unix-time))
            (create-time update-time))
        (progn (save-article* articleid :title title :content content :update-at update-time :create-at create-time)
            (format nil 
                (encode-json-plist-to-string 
                    (list "id" articleid "url" (concatenate 'string "/blog/articles/" articleid)))))))


(defun get-article (articleid)
        (multiple-value-bind (title content views update-time create-time) (get-article* articleid)
            (if title
                (progn
                    (increase-view-times* articleid)
                    (setf (content-type*) "application/json")
                    (format nil 
                        (encode-json-plist-to-string
                            (list "title" title "content" content "views" views "update-at" update-time "create-at" create-time))))
                (not-found)))
        )

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
            (articleid (car (last (split-sequence:split-sequence #\/ (request-uri*)))))
            (update-time (get-unix-time)))
        (progn (save-article* articleid :title title :content content :update-at update-time)
            (format nil 
                (encode-json-plist-to-string 
                    (list "id" articleid "url" (concatenate 'string "/blog/articles/" articleid)))))))