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
                (:file "articles" :depends-on ("db"))
                (:file "auth" :depends-on ("utils"))
                (:file "handlers" :depends-on ("utils" "auth" "articles" "mime"))
                (:file "dispatch" :depends-on ("utils" "handlers"))))