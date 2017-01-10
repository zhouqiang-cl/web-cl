(defsystem "web-cl"
  :description "web-cl: a sample web system."
  :version "0.0.1"
  :author "Zhou Qiang <zhouqiang.cl@gmail.com>"
  :licence "Public Domain"
  :depends-on (:hunchentoot
                :uuid
                :cl-json
                :cl-mongo
                :split-sequence)
  :components ((:file "packages")
                (:file "utils")
                (:file "db")
                (:file "mime")
                (:file "articles")
                (:file "auth")
                (:file "handlers")
                (:file "dispatch")
                (:file "id")
                (:file "misc")
                (:file "cookie")))