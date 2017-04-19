;;; packages.el --- rtags layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Alessandro Piras <laynor@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `rtags-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `rtags/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `rtags/pre-init-PACKAGE' and/or
;;   `rtags/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst rtags-packages
  '(rtags
    company-rtags))

(defun rtags/init-company-rtags ()
  (use-package company-rtags
    :defer t
    :config
    (push 'company-rtags company-backends-c-mode-common)))

(defun rtags/init-rtags ()
  (use-package rtags
    :defer t
    :init
    (progn
      (if (configuration-layer/package-usedp 'helm)
          (setq rtags-use-helm t))
      (spacemacs/rtags-define-keys-for-mode 'c-mode)
      (spacemacs/rtags-define-keys-for-mode 'c++-mode)
      (spacemacs/rtags-define-keys-for-mode 'objc-mode))
    :config
    (progn
      (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
      (add-hook 'c++-mode-common-hook 'rtags-start-process-unless-running)
      )))

;;; packages.el ends here
