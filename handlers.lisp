(in-package :web-cl)

(defun rander (path)
    (let ((mime-type (get-file-mime-type path)))
         (handle-static-file path mime-type)))

(defun index-handler () (redirect "/blog/articles"))

(defun write-handler () (require-admin-permission (rander "templates/write.html")))

(defun articles-template () 
    (let ((last-path (car (last (split-sequence:split-sequence #\/ (request-uri*))))))
        (case (intern (string-upcase last-path))
            (articles (rander "templates/articles.html"))
            (edit (rander "templates/edit.html"))
            (t (rander "templates/article.html")))))

(defun articles-handler ()
    (case (request-method*)
        (:GET  (handler-articles))
        (:POST (require-admin-permission (post-article)))
        (:PUT (require-admin-permission (put-article)))))

(defun article-update-handler ()
    (require-admin-permission (put-article)))

(defun login-handler ()
    (case (request-method*)
        (:GET (login))
        (:POST (auth))))

(defun serve-static-dir ()
    (let ((path (string-left-trim "/" (request-uri*)))) (rander path)))
