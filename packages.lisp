(in-package :cl-user)

(defpackage #:web-cl
  (:nicknames #:webcl)
  (:use :hunchentoot :cl :uuid :cl-json :cl-mongo))