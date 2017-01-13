(in-package :web-cl)

(defun index-handler () (redirect "/blog/articles"))

(defun write-handler () (require-admin-permission (rander "templates/write.html")))

(defun edits-handler () (require-admin-permission (rander "templates/edit_articles.html")))

(defun articles-template () 
    (let ((last-path (car (last (split-sequence:split-sequence #\/ (string-left-trim "/" (request-uri*)))))))
        (cond ((string= last-path "articles")
                (rander "templates/articles.html"))
              ((string= last-path "edit")
                (rander "templates/edit.html"))
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
