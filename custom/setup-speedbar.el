;; speedbar 토글.
(defun my-speedbar ()
  "Toggle sr-speedbar and select"
  (interactive)
  (progn
    (sr-speedbar-toggle)
    (if (sr-speedbar-exist-p)
        (sr-speedbar-select-window))))

(use-package sr-speedbar
  :init
  (progn
    (setq sr-speedbar-right-side nil)
    (setq sr-speedbar-auto-refresh t))
  :bind
  (("C-x p" . 'my-speedbar)))

(provide 'setup-speedbar)
