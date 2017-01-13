(in-package :web-cl)


(defvar *cookie-secret* "NWM5NTk3ZjNjODI0NTkwN2VhNzFhODlkOWQzOWQwOGUK")

(defun create-signature (cookie_secret name value timestamp)
    (let ((digest_str (concatenate 'string cookie_secret name value timestamp)))
        (sha1 digest_str)))

(defun join (value timestamp signature)
    (concatenate 'string value "|" timestamp "|" signature))

(defun create-signed-value (name value timestamp)
    (let* ( (timestamp (write-to-string timestamp))
            (value (base64 value))
            (signature (create-signature *cookie-secret* name value timestamp))
            (new-value (join value timestamp signature)))
    new-value))

(defun decode-signed-value (name value)
  (let* ((parts (split-sequence:split-sequence #\| (string-trim "|" value)))
        (signature (create-signature *cookie-secret* name (car parts) (cadr parts))))
      (progn
        (print signature)
        (print (caddr parts))
      (if (string= signature (caddr parts))
          (base64decode (car parts))
          nil))))