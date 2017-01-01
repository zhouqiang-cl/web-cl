(defun index-handler () (format nil "welcome to zhouqiang's blog"))

(defun write-handler () (rander "templates/write.html"))

(defun article-handler () 
    (let ((path (request-uri*)))
        (if (string= (string-right-trim "/" path) "/articles")
            (rander "templates/articles.html")
            (rander "templates/article.html"))))

(defun upload-article () 
    (let ((title (post-parameter "title"))
            (content (post-parameter "content"))
            (itemid (genitemid)))
    (save-article itemid title content)))