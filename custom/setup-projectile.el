(setq projectile-keymap-prefix (kbd "C-c C-p"))
(define-key projectile-mode-map [?\s-d] 'helm-projectile-find-dir)
(define-key projectile-mode-map [?\s-f] 'helm-projectile-find-file-dwim)

(provide 'setup-projectile)
