(defclass base-handler () ())
(defgeneric http-get (h base-handler))
(defclass my-handler (base-handler) ())
(defmethod method-get ((handler my-handler)) (format t "xx"))
; (http-get (make-instance 'my-handler))