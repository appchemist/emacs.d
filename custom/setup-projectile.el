;; (use-package projectile
;;   :init
;;   (projectile-global-mode)
;;   (setq projectile-enable-caching t)
;;   (setq projectile-completion-system 'helm)
;;   (helm-projectile-on))
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (setq projectile-enable-caching t
        projectile-indexing-method 'alien
        projectile-completion-system 'helm
        projectile-switch-project-action 'helm-projectile)
  ;; https://github.com/bbatsov/projectile/issues/1183
  (setq projectile-mode-line
        '(:eval (format " Projectile[%s]"
                        (projectile-project-name))))
  (projectile-global-mode))

(use-package helm-projectile
  :ensure t
  :commands (helm-projectile)
  :after helm
  :config (helm-projectile-on))
(setq projectile-keymap-prefix (kbd "C-c C-p"))
(define-key projectile-mode-map [?\s-d] 'helm-projectile-find-dir)
(define-key projectile-mode-map [?\s-f] 'helm-projectile-find-file-dwim)

(provide 'setup-projectile)
