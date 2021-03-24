(use-package org-bullets
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1)
                             (org-indent-mode 1))))

(use-package ox-pandoc
  :ensure t
  :after org
  :init
  ;; pandoc 때문에 경로 추가
  ;; pandoc 패키지 설치 필요
  ;; mac의 경우 - brew install pandoc
  (add-to-list 'exec-path "/usr/local/bin"))
(use-package latex-extra
  :ensure t
  :hook (LaTeX-mode . latex-extra-mode))

(use-package org-roam
  :ensure t
  :after org
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/Dropbox/org/org-roam")
  (org-roam-graph-executable "/usr/local/bin/dot")
  (org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
  :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph-show))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(require 'org-roam-protocol)

(use-package org-download
  :ensure t
  :after org
  :hook
  (dired-mode-hook . org-download-enable)
  :custom
  (org-download-image-dir "./image/")
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank))))

(require 'org-attach)
(setq org-link-abbrev-alist '(("fast" . "./image/")))
(setq org-link-abbrev-alist '(("file" . org-attach-expand-link)))

(setq org-directory "~/Dropbox/org")
(setq org-main-gtd (concat org-directory "/gtd/gtd.org"))
(setq org-default-notes-file (concat org-directory "/refile.org"))

;; Key Configuration for org
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c i") 'org-clock-in)
(global-set-key (kbd "C-c o") 'org-clock-out)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-switchb)

(setq org-agenda-files
   `(,org-main-gtd ,(concat org-directory "/gtd/appchemist.org") ,(concat org-directory "/gtd/config_gtd.org")))

;; Set a task which is clock-in to clock-out when exit emacs
(defun org/exit ()
  (with-current-buffer (find-file-noselect org-main-gtd)
    (save-excursion
      (org-clock-out nil t)
      (save-buffer))))
(add-hook 'kill-emacs-hook #'org/exit)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      `(("w" "todo" entry (file+headline ,org-main-gtd "Eden")
         "* BACKLOG %?\n" :clock-in t)
        ("m" "Meeting" entry (file+headline ,org-main-gtd "Meeting")
         "* MEETING %?     :Meeting:\nSCHEDULED: %^t\n  %U" :tag 'Meeting)
        ("t" "할일 todo" entry (file+headline "~/Dropbox/org/gtd/appchemist.org" "할일 리스트")
         "* BACKLOG %?\n" :clock-in t :clock-resume t)
        ("c" "Study CS" entry (file+headline "~/Dropbox/org/gtd/appchemist.org" "Study CS")
         "* STUDY %?\n")
        ))

;; '@' is for a note with timestamp
;; '!' is for a timestamp
;; '/!' is for a timestamp when leaving that state
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "WAITING(w!/@)" "REVIEW(r!/@)" "POSTPONE(p@)" "|" "CANCELED(c@)")
        (sequence "MEETING(m)" "|")
        (sequence "STUDY(y)" "STUDYING(i)" "|")
        (sequence "QA(q!/@)" "|")
        (sequence "BACKLOG(b)" "|")
        (sequence "|" "DONE(d!)" "COMPLETE(z!)")))

(setq org-todo-keyword-faces
      '(("TODO" . "red") ("STUDY" . "red") ("MEETING" . "red") ("STARTED" . "green") ("STUDYING" . "green")
        ("WAITING" . (:background "white" :foreground "red" :weight bold))
        ("REVIEW" . (:background "white" :foreground "green" :weight bold))
        ("QA" . (:background "white" :foreground "orange" :weight bold))
        ("POSTPONE" . "yellow") ("CANCELED" . (:foreground "blue" :weight bold))))

(setq org-refile-targets
      `((,org-agenda-files :maxlevel . 2)
        (,(concat org-directory "/gtd/complete.org") :maxlevel . 1)))
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path t)

(setq org-agenda-custom-commands
      '(("w" "Agenda and Work-related tasks"
         (;; One block with a standard agenda view
          (agenda ""
                  ((org-agenda-span 'day)
                   (org-agenda-overriding-header
                    "Today's Schedule:")))
          (tags-todo "+PRIORITY={A}"
                     ((org-agenda-skip-function '(org-agenda-skip-entry-if 'DONE 'CANCELED))
                      (org-agenda-overriding-header
                       "Priority tasks")))
          (todo "BACKLOG"
                   ((org-agenda-skip-function
                     '(org-agenda-skip-if nil '(scheduled deadline)))
                    (org-agenda-sorting-strategy '((todo todo-state-down priority-down)))
                    (org-agenda-overriding-header
                     "BackLog")))
          (todo "TODO"
                ((org-agenda-skip-function
                  '(org-agenda-skip-if nil '(scheduled deadline)))
                 (org-agenda-sorting-strategy '((todo todo-state-down priority-down)))
                 (org-agenda-overriding-header
                  "Ready")))
          (todo "STARTED|REVIEW|QA|WAITING"
                ((org-agenda-skip-function
                  '(org-agenda-skip-if nil '(scheduled deadline)))
                 (org-agenda-sorting-strategy '((todo todo-state-down priority-down)))
                 (org-agenda-overriding-header
                  "Doing")))
          (todo "DONE"
                ((org-agenda-overriding-header
                  "Done")))
          (agenda "Week At A Glance:"
                  ((org-agenda-span '14)
                   (org-agenda-start-day "+1d")
                   (org-agenda-start-on-weekday nil)
                   (org-agenda-overriding-header
                    "2 Week At A Glance:")))
          (todo "POSTPONE"
                ((org-agenda-overriding-header
                  "Postpone Tasks")))
          ))))

(setq org-image-actual-width (/ (display-pixel-width) 3))

(defun open-my-org ()
  (interactive)
  (find-file (concat org-directory "/gtd/gtd.org")))

(setq org-agenda-start-with-follow-mode t)

(require 'ox-latex)
(setq org-latex-listings t)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (awk . t)
   (calc .t)
   (C . t)
   (emacs-lisp . t)
   (haskell . t)
   (gnuplot . t)
   (latex . t)
   ;;(ledger . t)
   (js . t)
   (haskell . t)
   ;;(http . t)
   (perl . t)
   (python . t)
   ;; (gnuplot . t)
   ;; org-babel does not currently support php.  That is really sad.
   ;;(php . t)
   (R . t)
   (scheme . t)
   (shell . t)
   (sql . t)
   (plantuml . t)
   ;;(sqlite . t)
   ))

;;;;;;;;;;;;;;;;;;;;;
;; plantuml config ;;
;;;;;;;;;;;;;;;;;;;;;
;; image
(setq org-startup-with-inline-images t)

;; plantuml 설정
;; class diagram을 출력하기 위해서는 graphviz를 설치해야 한다.
;; mac의 경우 - brew install graphviz
(setq org-confirm-babel-evaluate nil)
(setq org-plantuml-jar-path
      (expand-file-name
       ;; plantuml 설치 위치 지정
       "/Users/gyeongwon.do/.emacs.d/custom/package/plantuml.jar"))
(add-hook 'org-babel-after-execute-hook
          (lambda ()
            (when org-inline-image-overlays
              (org-redisplay-inline-images))))
(add-to-list 'org-structure-template-alist
             '("u" "#+BEGIN_SRC plantuml :file ?.png
\nskinparam monochrome true
\n#+END_SRC"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; end of plantuml config ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'setup-org)
