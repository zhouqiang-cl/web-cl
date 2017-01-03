(load "request.lisp")
(load "packages.lisp")
(in-package :web-cl)
(defvar *mime-table* (make-hash-table))
(load "mime.lisp")
(load "utils.lisp")
(defvar *admin-user-table* (make-hash-table))
(load "auth.lisp")
(load "db.lisp")
(load "articles.lisp")
(load "handlers.lisp")
(load "dispatch.lisp")
(init-mime-table mime-table *mime-table*)
(start-web)