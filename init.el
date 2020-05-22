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
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-helm)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-speedbar)
(require 'setup-projectile)
(require 'setup-slime)
(require 'setup-org)
(require 'ox-latex)
;; ox-confluence git에서 코드를 가져옴
(require 'ox-confluence)

(setq org-latex-listings t)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))

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
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(org-agenda-files
   (quote
    ("/Users/gyeongwon.do/Dropbox/org/gtd/gtd.org" "/Users/gyeongwon.do/Dropbox/org/gtd/appchemist.org" "/Users/gyeongwon.do/Dropbox/org/gtd/complete.org" "/Users/gyeongwon.do/Dropbox/org/gtd/config_gtd.org")))
 '(package-selected-packages
   (quote
    (slime org-bullets flycheck helm-ag ivy eyebrowse projectile doom-themes smart-mode-line htmlize ox-pandoc latex-extra auctex which-key function-args ggtags cyberpunk-2019-theme cyberpunk-theme zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
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

;; GNU screen inside GNU Emacs
(defun term-screen ()
  (interactive)
  "Open GNU screen session or reattaches existing one"
  (require 'term)
  (setq term-ansi-buffer-name (concat "*" "terminal" "*"))
  (term-ansi-make-term term-ansi-buffer-name
                       "/usr/bin/screen" nil "-d" "-R" "-U")
  (set-buffer term-ansi-buffer-name)
  (term-mode)
  (term-char-mode)
  (term-set-escape-char ?\C-x)
  (switch-to-buffer term-ansi-buffer-name))

(global-set-key (kbd "C-c t") 'term-screen)
;;;

;;;
(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)
(setq default-process-coding-system '(utf-8-hfs . utf-8-hfs))
;;;

(require 'doom-modeline)
(doom-modeline-mode 1)

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(yas-global-mode t)
