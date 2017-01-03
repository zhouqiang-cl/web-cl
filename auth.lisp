(defun login ()
    (rander "templates/login.html"))

(defun redirect-to-login ()
    (login))


(defun set-web-cookie (name value)
    (set-cookie name :value value :secure t))

(defun get-web-cookie (name)
    (cookie-in name))

(defun create-admin-user (users)
    (mapcar (lambda (args)
        (setf (gethash (intern (string-upcase (car args))) *admin-user-table*) (cadr args))) users))

(defun user-authentication (user passwd)
    (string= (gethash (intern (string-upcase user)) *admin-user-table*) passwd))

(defun user-authorization (user)
    (set-web-cookie "user" user))


(defun authed ()
    (let ((name (get-web-cookie "user")))
        (gethash (intern (string-upcase name)) *admin-user-table* )))

(defun login-success (redirect-url)
    (format nil
        (encode-json-plist-to-string
            (list "redirect-url" redirect-url "status" "success"))))

(defun login-failed ()
    (format nil
        (encode-json-plist-to-string
            (list "redirect-url" "/login" "status" "failed"))))

(defun auth ()
    (let (  (user (post-parameter "username"))
            (passwd (post-parameter "password")))
        (if (user-authentication user passwd)
            (progn
                (user-authorization user)
                (login-success "/write"))
            (login-failed))))

(defmacro admin (func) 
    `(if (authed) 
        ,func
        (redirect-to-login)))

(create-admin-user '(("zhouqiang" "zhouqiang-passwd")))
