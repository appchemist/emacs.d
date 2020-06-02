(require 'package)
;; default package archives
;; (add-to-list 'package-archives
;;             '(("melpa" . "http://melpa.org/packages/")
;;               ("melpa-stable" . "https://stable.melpa.org/packages/")
;;               ("gnu" . "https://elpa.gnu.org/packages/")
;;               ("org" . "http://orgmode.org/elpa/")))

;; mac os default package archives
;;(setq package-archives '(("gnu" . "http://mirrors.163.com/elpa/gnu/")
;;                         ("melpa" . "https://melpa.org/packages/")
;;                         ("org" . "http://orgmode.org/elpa/")))

;; for pandoc packages archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; (dolist (package '(ace-window slime flycheck helm-ag ivy eyebrowse projectile doom-themes smart-mode-line htmlize latex-extra which-key function-args ggtags cyberpunk-2019-theme cyberpunk-theme zygospore helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))
;;   (unless (package-installed-p package)
;;     (package-install package))
;;   (require package))

;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ox-latex slime flycheck helm-ag ivy eyebrowse projectile doom-themes smart-mode-line htmlize ox-pandoc auctex which-key function-args ggtags cyberpunk-2019-theme cyberpunk-theme zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#282c34" :foreground "#bbc2cf" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "D2Coding")))))

(setenv "PATH"
        (concat
         ;; latex 위치를 못 찾을 경우 해당 경로를 지정
         "/Library/TeX/texbin/" ":"
         "/usr/local/bin/" ":"
         (getenv "PATH")))

;;;
(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)
(setq default-process-coding-system '(utf-8-hfs . utf-8-hfs))
;;;

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")
(require 'setup-themes)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-helm)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-speedbar)
(require 'setup-projectile)
(require 'setup-slime)
(require 'setup-org)
;; ox-confluence git에서 코드를 가져옴
(require 'ox-confluence)
(require 'setup-general)
