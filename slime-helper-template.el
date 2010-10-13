;;;; This file was created automatically by the Quicklisp library
;;;; "quicklisp-slime-helper" from the "quicklisp" dist.

(setq quicklisp-slime-helper-dist "quicklisp")

(setq quicklisp-slime-helper-base
      (if load-file-name
          (file-name-directory load-file-name)
        (expand-file-name "~/quicklisp/")))

(defun quicklisp-slime-helper-file-contents (file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

(defun quicklisp-slime-helper-slime-directory ()
  (let ((location-file (concat quicklisp-slime-helper-base
                               "dists/"
                               quicklisp-slime-helper-dist
                               "/installed/systems/swank.txt")))
    (when (file-exists-p location-file)
      (let ((relative (quicklisp-slime-helper-file-contents location-file)))
        (file-name-directory (concat quicklisp-slime-helper-base
                                     relative))))))

; stolen from Debian slime package
(let* ((package-dir (quicklisp-slime-helper-slime-directory))
       (slime-autoloads (concat package-dir "slime-autoloads.elc")))
  (setq load-path (cons package-dir
                        (cons (concat package-dir "contrib")
                              load-path)))

  (setq slime-backend
        (concat package-dir "swank-loader.lisp"))
  (message slime-backend)

  (if (file-exists-p slime-autoloads)
      (load slime-autoloads)
      (load (concat package-dir "slime-autoloads.el"))))

(eval-after-load "slime"
  '(progn
    (slime-setup '(slime-fancy slime-asdf slime-banner))
    (setq slime-complete-symbol*-fancy t)
    (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)))
