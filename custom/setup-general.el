(menu-bar-mode -1)
(tool-bar-mode -1)
(which-key-mode 1)
(eyebrowse-mode 1)
(yas-global-mode t)

(set-language-environment "Korean")
(prefer-coding-system 'utf-8)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

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

(defalias 'yes-or-no-p 'y-or-n-p)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; company
(use-package company
  :init
  (global-company-mode 1)
  (delete 'company-semantic company-backends))
;; (define-key c-mode-map  [(control tab)] 'company-complete)
;; (define-key c++-mode-map  [(control tab)] 'company-complete)


;; Package zygospore
(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows)
         ("RET" .   newline-and-indent)))

  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(windmove-default-keybindings)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(global-set-key (kbd "C-c t") 'term-screen)
(global-set-key (kbd "s-1") 'eyebrowse-switch-to-window-config-1)
(global-set-key (kbd "s-2") 'eyebrowse-switch-to-window-config-2)
(global-set-key (kbd "s-3") 'eyebrowse-switch-to-window-config-3)
(global-set-key (kbd "s-4") 'eyebrowse-switch-to-window-config-4)
(global-set-key (kbd "s-5") 'eyebrowse-switch-to-window-config-5)

(global-set-key (kbd "C-c w") 'whitespace-mode)
(global-set-key (kbd "s-[") 'previous-buffer)
(global-set-key (kbd "s-]") 'next-buffer)
(global-set-key (kbd "M-n") 'ace-window)
(global-set-key (kbd "S-SPC") 'toggle-korean-input-method)

(provide 'setup-general)
