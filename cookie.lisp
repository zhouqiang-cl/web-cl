(in-package :web-cl)

(defun set-web-cookie (name value)
    (set-cookie name :value value))

(defun get-web-cookie (name)
    (cookie-in name))

(defun set-web-secure-cookie (name value)
    (let* ((timestamp (get-unix-time))
            (new-value (create-signed-value name value timestamp)))
        (set-web-cookie name new-value)))

(defun get-web-secure-cookie (name)
    (let* ((value (cookie-in name)))
        (decode-signed-value name value)))