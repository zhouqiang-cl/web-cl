#sbcl newest, asdf newest
sbcl --load quicklisp.lisp
(quicklisp-quickstart:install)
(ql:add-to-init-file)
(ql:quickload "flexi-streams")
(ql:quickload "ironclad")
(ql:quickload "split-sequence")
(ql:quickload "cl-mongo")
(ql:quickload "hunchentoot")
(ql:quickload "cl-json")
(load "/path/to/asdf.lisp")
(asdf:asdf-version)