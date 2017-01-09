(in-package :web-cl)

(defun set-web-cookie (name value)
    (set-cookie name :value value))

(defun get-web-cookie (name)
    (cookie-in name))