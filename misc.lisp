(in-package :web-cl)

(defun rander (path)
    (let ((mime-type (get-file-mime-type path)))
         (handle-static-file path mime-type)))

(defun not-found ()
    (setf (return-code*) 404)
    (format nil 
        (encode-json-to-string 
            (list (cons "redirect-url" "/static/html/404.html")))))

(defun login ()
    (rander "templates/login.html"))

(defun redirect-to-login ()
    (redirect "/login"))

(defun login-failed ()
    (format nil
        (encode-json-plist-to-string
            (list "redirect-url" "/login" "status" "failed"))))

(defun login-success (redirect-url)
    (format nil
        (encode-json-plist-to-string
            (list "redirect-url" redirect-url "status" "success"))))
