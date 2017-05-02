;;; funcs.el --- gtags functions File -*- lexical-binding: t -*-
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; URL: https://github.com/syl20bnr/spacemacs
;; Author: Alessandro Piras <laynor@gmail.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defun spacemacs/rtags-local-set-keys ()
  (local-set-key (kbd "M-.") 'rtags-find-symbol-at-point)
  (local-set-key (kbd "M-,") 'rtags-find-all-references-at-point))

(defun rtags-rc ()
  (concat rtags-install-directory "/bin/rc"))

(defun rtags-index-project ()
  (interactive)
  (let* ((project-root (ignore-errors (projectile-project-root)))
         (dir (read-directory-name "Index with RTags: " project-root)))
    (start-process "rc" "*rtags indexer*" (rtags-rc) "-J" "--wait" dir)))

(defun spacemacs//rtags-clone-rtags (directory completion)
  (let ((process (start-process "rtags-clone" "*rtags clone*"
                                "git" "clone" "--recursive"
                                "https://github.com/Andersbakken/rtags.git" directory)))
    (set-process-sentinel process (lambda (process event)
                                    (if (s-equals? "finished\n" event)
                                        (funcall completion directory))))))

(defun spacemacs//rtags-build (directory)
  (let ((build-dir (concat directory "rtags/build")))
    (message "Build dir: %s" build-dir)
    (mkdir build-dir)
    (let ((default-directory build-dir))
      (with-current-buffer (compilation-start "cmake .." nil #'(lambda (maj-mode )
                                                                 "*rtags build*"))
        (setq-local compilation-finish-function
                    '(spacemacs//rtags-install-finish-function))))))

(defun spacemacs//rtags-install-finish-function (buffer msg)
  (if (s-equals? "finished\n" msg)
      (message "RTags installed successfully!")
    (message "Failed to build RTags.")))


(defun spacemacs/rtags-install-rtags ()
  (interactive)
  (let ((build-directory (concat temporary-file-directory
                                 (make-temp-name "rtags-build"))))
    (spacemacs//rtags-clone-rtags build-directory #'spacemacs//rtags-build)))

(defun spacemacs/rtags-define-keys-for-mode (mode)
  "Define key bindings for the specific MODE"
  (when (fboundp mode)
    (let ((hook (intern (concat (symbol-name mode) "-hook"))))
      (add-hook hook 'spacemacs/rtags-local-set-keys)
      (spacemacs/set-leader-keys-for-major-mode mode
        "RET" 'rtags-fix-fixit-at-point
        "rr" 'rtags-rename-symbol
        "rd" 'rtags-create-doxygen-comment
        "gg" 'rtags-find-symbol-at-point
        "gu" 'rtags-find-all-references-at-point
        "gf" 'rtags-find-functions-called-by-this-function
        "gi" 'rtags-index-project))))
