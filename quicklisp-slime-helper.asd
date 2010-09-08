;;;; quicklisp-slime-helper.asd

(asdf:defsystem #:quicklisp-slime-helper
  :depends-on (#:swank
               #:alexandria)
  :components ((:file "slime-helper")))
