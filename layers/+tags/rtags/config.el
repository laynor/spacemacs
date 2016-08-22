;;; config.el --- rtags layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Alessandro Piras <laynor@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(spacemacs|defvar-company-backends c-mode)
(spacemacs|defvar-company-backends c++-mode)
(spacemacs|defvar-company-backends objc-mode)

(defvar rtags-enable-company-backend t
  "If non nil, push the rtags company backend to company-backends")

(defvar rtags-install-directory (concat user-emacs-directory "/private/external-software/rtags"))
