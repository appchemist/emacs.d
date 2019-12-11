(require 'package)
;; default package archives
(add-to-list 'package-archives
             '(("melpa" . "http://melpa.org/packages/")
               ("melpa-stable" . "https://stable.melpa.org/packages/")
               ("gnu" . "https://elpa.gnu.org/packages/")
               ("org" . "http://orgmode.org/elpa/")))

;; mac os default package archives
;;(setq package-archives '(("gnu" . "http://mirrors.163.com/elpa/gnu/")
;;                         ("melpa" . "https://melpa.org/packages/")
;;                         ("org" . "http://orgmode.org/elpa/")))

;; for pandoc packages archives
;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("melpa" . "http://melpa.milkbox.net/packages/")
;;                          ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'default-frame-alist
             '(font . "D2Coding"))

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-speedbar)
(require 'ox-latex)
;; ox-confluence git에서 코드를 가져옴
(require 'ox-confluence)

(setq org-latex-listings t)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))

(load-file "~/.emacs.d/custom/setup-org.el")

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(load-theme 'cyberpunk t)

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
 '(org-agenda-files (quote ("~/Dropbox/org/gtd")))
 '(package-selected-packages
   (quote
    (ox-pandoc latex-extra auctex which-key function-args ggtags cyberpunk-2019-theme cyberpunk-theme zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setenv "PATH"
        (concat
                ;; latex 위치를 못 찾을 경우 해당 경로를 지정
                "/Library/TeX/texbin/" ":"
                "/usr/local/bin/" ":"
                (getenv "PATH")))
