(use-package function-args
  :ensure t
  :config
  (fa-config-default)
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)))

(provide 'setup-function-args)
