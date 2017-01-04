(defun index-handler () (redirect "/blog/articles"))

(defun write-handler () (require-admin-permission (rander "templates/write.html")))

(defun articles-template () 
    (let ((path (request-uri*)))
        (if (string= (string-right-trim "/" path) "/blog/articles")
            (rander "templates/articles.html")
            (rander "templates/article.html"))))

(defun articles-handler ()
    (case (request-method*)
        (:GET  (handler-articles))
        (:POST (require-admin-permission (post-article)))
        (:PUT (require-admin-permission (put-article)))))

(defun login-handler ()
    (case (request-method*)
        (:GET (login))
        (:POST (auth))))

(defun serve-static-dir ()
    (let ((path (string-left-trim "/" (request-uri*)))) (rander path)))
