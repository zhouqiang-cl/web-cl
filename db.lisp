(in-package :web-cl)

(defvar *mongodb-default-host* "localhost" "host to connect")
(defvar *articles-default-db* "blog")
(defvar *articles-default-port* 27017)
(defvar *articles-default-collection* "articles" "the articles db connection")
(defvar *articles-db* nil "the articles db connection")
(defvar *mongo-name* "articles-db")

(defclass articles-db ()
    (
        (collection :accessor collection
                    :initform "articles"
                    :documentation "the collection which articles used")
    ))

(defmethod initialize-instance :after ((articles-db articles-db) &key 
        (host *mongodb-default-host*) 
        (port *articles-default-port*)
        (db   *articles-default-db*)
        (collection *articles-default-collection*))
        (progn 
            (mongo :name *mongo-name* :host host :port port :db db)
            (db.use db)))

;;;help function to build or update item var
(defun make-item (itemid &key title content views)
    (kv (kv "_id" itemid) (kv "title" title) (kv "content" content) (kv "views" views)))


(defun update-item (item &key title content views)
    (progn 
        (if title
            (add-element "title" title item))
        (if content
            (add-element "content" content item))
        (if views
            (add-element "views" views item))
        (return-from update-item item)))

;;;lower level function to find save item
(defun find-item (itemid)
    (car (docs  (db.iter (db.find (collection *articles-db*) (kv "_id" itemid))))))

(defun find-items ()
    (docs (db.iter (db.find (collection *articles-db*) :all))))

(defun save-item (item)
    (db.save (collection *articles-db*) item))


;;;db top level api
(defun start-articles-db (&key (host #(127 0 0 1)) (port 27017) (db "blog") (collection "articles"))
    (setf *articles-db* (make-instance 'articles-db
                                    :host host :port port :db db :collection collection)))

(defun save-article* (itemid &key title content)
    (let ((item (find-item itemid)))
        (progn
            (defvar new-item nil)
            (if item (setf new-item (update-item item :title title :content content))
                (setf new-item (make-item itemid :title title :content content :views 0)))
            (save-item new-item))))


(defun get-article* (itemid)
    (let ((item (find-item itemid)))
            (values (get-element "title" item)
                (get-element "content" item)
                (get-element "views" item))))

(defun get-articles* ()
    (loop for item in (find-items)
        collect (list (doc-id item)
                        (get-element "title" item))))


(defun increase-view-times* (itemid)
    (let* ((item (find-item itemid)) (views (+ 1 (get-element "views" item))))
        (progn
            (add-element "views" views item)
            (save-item item))))

