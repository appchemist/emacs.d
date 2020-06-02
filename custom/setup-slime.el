(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/local/bin/clisp")
  (slime-setup))

(provide 'setup-slime)
