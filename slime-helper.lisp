;;;; slime-helper.lisp

(defpackage #:quicklisp-slime-helper
  (:use #:cl)
  (:export #:install)
  (:shadowing-import-from #:alexandria
                          #:copy-file)
  (:shadowing-import-from #:ql-dist
                          #:ensure-installed
                          #:find-system)
  (:shadowing-import-from #:ql-setup
                          #:qmerge))

(in-package #:quicklisp-slime-helper)

(defun install ()
  (let ((source (asdf:system-relative-pathname "quicklisp-slime-helper"
                                               "slime-helper-template"
                                               :type "el"))
        (target (qmerge "slime-helper.el")))
    (copy-file source target)
    (ensure-installed  (find-system "swank"))
    (format t "~&slime-helper.el installed in ~S~%~%"
            (namestring target))
    (format t "To use, add this to your ~~/.emacs:~%~%")
    #+win32
    (progn
      ;; windows emacs can map ~ all over the place, see 
      ;; http://www.gnu.org/software/emacs/windows/big.html#index-HOME-directory-49
      ;; emit elisp so emacs calculates the right path to slime-helper.el based on where it thinks ~ is
      (format t "  (load ~S)~%" 
	      (concatenate 'string
			   #-lispworks (pathname-device (user-homedir-pathname))
			   #+lispworks (pathname-host (user-homedir-pathname))
			   ":"
			   (namestring target))))
    #-win32
    (let ((enough (enough-namestring target (user-homedir-pathname))))
      (unless (equal (pathname enough) target)
        (setf enough (format nil "~~/~A" enough)))
      (format t "  (load (expand-file-name ~S))~%" enough))
    (format t "  (require 'slime)~%~%")))
