(defun index-handler () (format nil "welcome to zhouqiang's blog"))

(defun write-handler () (rander "templates/write.html"))

(defun article-handler () 
    (let ((path (request-uri*)))
        (if (string= (string-right-trim "/" path) "/articles")
            (rander "templates/articles.html")
            (rander "templates/article.html"))))

(defun articles-handler ()
    (case (request-method*)
        (:GET (get-article))
        (:POST (post-article))
        (:PUT (put-article))))

(defun login-handler ()
    (case (request-method*)
        (:GET (login))
        (:POST (auth))))

(defun serve-static-dir ()
    (let ((path (string-left-trim "/" (request-uri*)))) (rander path)))
