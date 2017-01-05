(in-package :web-cl)
(defun save-article-to-db (itemid title content)
    (progn (db.use "blog")
        (db.insert "articles" (kv (kv "_id" itemid) (kv "title" title) (kv "content" content)))))

(defun update-article-to-db (itemid title content)
    (progn (db.use "blog")
        (db.update "articles" (kv "_id" itemid) (kv (kv "_id" itemid) (kv "title" title) (kv "content" content)))))

(defun get-article-from-db (itemid)
    (progn (db.use "blog")
        (values (get-element "title" (docs  (db.iter (db.find "articles" (kv "_id" itemid)))))
            (get-element "content" (docs  (db.iter (db.find "articles" (kv "_id" itemid))))))))

(defun get-articles-from-db ()
    (progn (db.use "blog")
        (loop for item in (docs (db.iter (db.find "articles" :all)))
            collect (list (cons "id" (doc-id item)) (cons "url" (concatenate 'string "/blog/articles/" (doc-id item))) (cons "title" (get-element "title" item))))))