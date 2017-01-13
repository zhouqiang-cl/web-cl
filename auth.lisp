(in-package :web-cl)

(defvar *admin-user-table* (make-hash-table :test 'equal))

(defun create-admin-user (users)
    (mapcar (lambda (args)
        (setf (gethash (car args) *admin-user-table*) (cadr args))) users))

(defun user-authentication (user passwd)
    (string= (gethash user *admin-user-table*) passwd))

(defun user-authorization (user)
    (set-web-secure-cookie "user" user))


(defun authed ()
    (let ((name (get-web-secure-cookie "user")))
            (gethash name *admin-user-table*)))

(defun auth ()
    (let (  (user (post-parameter "username"))
            (passwd (post-parameter "password")))
        (if (user-authentication user passwd)
            (progn
                (user-authorization user)
                (login-success "/"))
	(login-failed))))

(defmacro require-admin-permission (func) 
    `(if (authed) 
        ,func
        (redirect-to-login)))

(create-admin-user '(("zhouqiang" "zhouqiang-passwd")))
