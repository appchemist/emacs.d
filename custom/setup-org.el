(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file (concat org-directory "refile.org"))

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("w" "Wadiz todo" entry (file+headline "~/Dropbox/org/gtd/gtd.org" "Wadiz")
               "* TODO %?\n" :clock-in t :clock-resume t)
              ("t" "할일 todo" entry (file+headline "~/Dropbox/org/gtd/appchemist.org" "할일 리스트")
               "* TODO %?\n" :clock-in t :clock-resume t)
              ("c" "Study CS" entry (file+headline "~/Dropbox/org/gtd/appchemist.org" "Study CS")
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
  (find-file (concat org-directory "/gtd/gtd.org")))

;;;;;;;;;;;;;;;;;;;;;
;; plantuml config ;;
;;;;;;;;;;;;;;;;;;;;;
;; image
(setq org-startup-with-inline-images t)

;; plantuml 설정
;; class diagram을 출력하기 위해서는 graphviz를 설치해야 한다.
;; mac의 경우 - brew install graphviz
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-confirm-babel-evaluate nil)
(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/custom/package/plantuml.jar"))
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
