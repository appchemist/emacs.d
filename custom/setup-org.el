(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file (concat org-directory "refile.org"))

;; Key Configuration for org
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c i") 'org-clock-in)
(global-set-key (kbd "C-c o") 'org-clock-out)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-switchb)

'(org-agenda-files
  (quote
   ("~/Dropbox/org/gtd/gtd.org" "~/Dropbox/org/gtd/appchemist.org" "~/Dropbox/org/gtd/complete.org" "~/Dropbox/org/gtd/config_gtd.org")))

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("w" "Wadiz todo" entry (file+headline "~/Dropbox/org/gtd/gtd.org" "Wadiz")
               "* TODO %?\n" :clock-in t :clock-resume t)
              ("i" "Wadiz Issue todo" entry (file+headline "~/Dropbox/org/gtd/gtd.org" "Wadiz Issue")
               "* TODO %?\n" :clock-in t :clock-resume t)
              ("e" "Wadiz Etc todo" entry (file+headline "~/Dropbox/org/gtd/gtd.org" "Wadiz Etc")
               "* TODO %?\n" :clock-in t :clock-resume t)
              ("t" "할일 todo" entry (file+headline "~/Dropbox/org/gtd/appchemist.org" "할일 리스트")
               "* TODO %?\n" :clock-in t :clock-resume t)
              ("c" "Study CS" entry (file+headline "~/Dropbox/org/gtd/appchemist.org" "Study CS")
               "* STUDY %?\n")
              )))

;; '@' is for a note with timestamp
;; '!' is for a timestamp
;; '/!' is for a timestamp when leaving that state
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s!)" "POSTPONE(p@)" "|" "DONE(d!)" "CANCELED(c@)")))

(setq org-todo-keyword-faces
      '(("TODO" . "red") ("STARTED" . "green")
        ("POSTPONE" . "yellow") ("CANCELED" . (:foreground "blue" :weight bold))))

(setq org-refile-targets
      '((nil :maxlevel . 9)
        (org-agenda-files :maxlevel . 9)))
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
          (todo "TODO|STARTED"
                   ((org-agenda-skip-function
                     '(org-agenda-skip-if nil '(scheduled deadline)))
                    (org-agenda-sorting-strategy '((todo priority-up todo-state-down)))
                    (org-agenda-overriding-header
                     "TODO & Started Tasks")))
          (todo "POSTPONE"
                ((org-agenda-overriding-header
                  "Postpone Tasks")))
          (agenda "Week At A Glance:"
                  ((org-agenda-span '7)
                   (org-agenda-start-on-weekday nil)
                   (org-agenda-overriding-header
                    "Week At A Glance:")))
          ))))

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

;;;;;;;;;;;;;;;;;;;;;;;
;; org bullet config ;;
;;;;;;;;;;;;;;;;;;;;;;;
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;;;;;;;;;;;;;;;;;;;;;;

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
       "/usr/local/Cellar/plantuml/1.2020.6/libexec/plantuml.jar"))
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

;; pandoc 때문에 경로 추가
;; pandoc 패키지 설치 필요
;; mac의 경우 - brew install pandoc
(add-to-list 'exec-path "/usr/local/bin")
(provide 'setup-org)
