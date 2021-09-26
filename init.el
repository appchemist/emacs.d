(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
;; (add-to-list 'package-archives '("gnu" . "http://mirrors.163.com/elpa/gnu/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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
(require 'setup-ggtags)
(require 'setup-helm)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-speedbar)
(require 'setup-projectile)
(require 'setup-slime)
(require 'setup-org)
(require 'setup-c)
;; ox-confluence git에서 코드를 가져옴
(require 'ox-confluence)
(require 'setup-general)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#282c34" :foreground "#bbc2cf" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "D2Coding")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flycheck htmlize eyebrowse zygospore company which-key ace-window function-args slime iedit anzu comment-dwim-2 ws-butler dtrt-indent yasnippet undo-tree volatile-highlights helm-projectile helm-swoop helm-ag ggtags helm-gtags doom-themes doom-modeline org-roam use-package)))
