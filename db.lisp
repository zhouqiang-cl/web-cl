(defun save-article-to-db (itemid title content)
    (progn (db.use "blog")
        (db.insert "articles" (kv (kv "id" itemid) (kv "title" title) (kv "content" content)))))

(defun get-article-from-db (itemid)
    (progn (db.use "blog")
        (values (get-element "title" (docs  (db.iter (db.find "articles" (kv "id" itemid)))))
            (get-element "content" (docs  (db.iter (db.find "articles" (kv "id" itemid))))))))

(defun get-articles-from-db ()
    (progn (db.use "blog")
        (loop for item in (docs (db.iter (db.find "articles" :all)))
            collect (list (cons "id" (get-element "id" item)) (cons "title" (get-element "title" item))))))