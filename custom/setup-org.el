(setq org-directory "~/Dropbox/org/")
(setq org-default-notes-file (concat org-directory "refile.org"))

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("s" "new SURF todo" entry (file+headline "~/Dropbox/org/gtd.org" "New SURF")
               "* TODO %?\n" :clock-in t :clock-resume t)
              ("t" "할일 todo" entry (file+headline "~/Dropbox/org/gtd.org" "할일 리스트")
               "* TODO %?\n" :clock-in t :clock-resume t)
              ("c" "Study CS" entry (file+headline "~/Dropbox/org/gtd.org" "Study CS")
               "* STUDY %?\n")
              ;; ("r" "respond" entry (file "~/Dropbox/org/refile.org")
              ;;  "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ;; ("n" "note" entry (file "~/Dropbox/org/refile.org")
              ;;  "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ;; ("j" "Journal" entry (file+datetree "~/Dropbox/org/diary.org")
              ;;  "* %?\n%U\n" :clock-in t :clock-resume t)
              ;; ("w" "org-protocol" entry (file "~/Dropbox/org/refile.org")
              ;;  "* TODO Review %c\n%U\n" :immediate-finish t)
              ;; ("m" "Meeting" entry (file "~/Dropbox/org/refile.org")
              ;;  "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ;; ("p" "Phone call" entry (file "~/Dropbox/org/refile.org")
              ;;  "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ;; ("h" "Habit" entry (file "~/Dropbox/org/refile.org")
              ;;                 "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:R
              ;; EPEAT_TO_STATE: NEXT\n:END:\n"))))
              )))

(setq org-refile-targets '((org-agenda-files :maxlevel . 1)))

(defun open-my-org ()
  (interactive)
  (find-file (concat org-directory "gtd.org")))
