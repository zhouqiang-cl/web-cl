(in-package :web-cl)
(defun dispatch (dispatch-table)
    (setf *dispatch-table* 
        (mapcar (lambda (args) 
                    (apply 'create-prefix-dispatcher args)) dispatch-table)))


(defvar *unix-epoch-difference*
  (encode-universal-time 0 0 0 1 1 1970 0))

(defun universal-to-unix-time (universal-time)
  (- universal-time *unix-epoch-difference*))

(defun get-unix-time ()
  (universal-to-unix-time (get-universal-time)))

(defun base64 (str)
    (cl-base64:string-to-base64-string str))

(defun base64decode (str)
    (cl-base64:base64-string-to-string str))

(defun sha1 (str)
    (ironclad:byte-array-to-hex-string 
        (ironclad:digest-sequence :sha1 (flexi-streams:string-to-octets str))))

(defun start-web () (start (make-instance 'easy-acceptor :port 8080)))