;;;; quicklisp-slime-helper.asd

(asdf:defsystem #:quicklisp-slime-helper
  :depends-on (#:swank
               #:alexandria)
  :components ((:file "slime-helper")))

(defmethod perform :after ((o load-op)
                           (c (eql (find-system "quicklisp-slime-helper"))))
  (funcall (find-symbol "INSTALL" :quicklisp-slime-helper)))
