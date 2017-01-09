(in-package :web-cl)

(defun uuid-to-string (uuid)
    (string-downcase (print-bytes nil uuid)))

(defun genitemid ()  (uuid-to-string (make-v4-uuid)))