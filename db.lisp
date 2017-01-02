(defun save-article-to-db (itemid title content)
    (progn (db.use "blog")
        (db.insert itemid (kv (kv "title" title) (kv "content" content)))))

(defun get-article-from-db (itemid)
    (progn (db.use "blog")
        (db.find itemid)))