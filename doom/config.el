;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


(setq user-full-name "Yunlan Li"
      user-mail-address "yl4387@columbia.edu")
(setq doom-theme 'doom-one-light)
(setq display-line-numbers-type 'relative)


;;
;; Key Bindings
;;

(map! :leader "f t" 'neotree)


;;
;; Org Mode
;;

(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)

  (setq
   org-directory  "~/Dropbox/Life/org"
   org-hide-emphasis-markers t
   org-superstar-item-bullet-alist '((?* . ?•) (?+ . ?◦) (?- . ?•)))

  (org-add-link-type
   "color"
   (lambda (path)
     (message (concat "color "
                      (progn (add-text-properties
                              0 (length path)
                              (list 'face `((t (:foreground ,path))))
                              path) path))))
   (lambda (path desc format)
     (cond
      ((eq format 'html)
       (format "<span style=\"color:%s;\">%s</span>" path desc))
      ((eq format 'latex)
       (format "{\\color{%s}%s}" path desc))))))

(add-hook 'org-mode-hook
  (lambda ()
    (plist-put org-format-latex-options :scale 0.7)))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))

;;
;; Olivetti
;;

(use-package olivetti
  :init
  (setq olivetti-body-width 100))


;;
;;  Org Roam
;;

(setq org-roam-directory "~/Dropbox/Study/org-roam")
(require 'org-roam)
(org-roam-db-autosync-mode)


;;
;; Org Capture
;;

(defun yl/find-create-date-entry ()
  "Append to end of or create Org entry with date heading."
  (let*
      (
       (dayInLastWeek (org-read-date nil t "-7d"))
       (dayInNextWeek (org-read-date nil t "+7d"))
       (thisMonday (org-read-date nil t "++Mon" nil dayInLastWeek))
       (thisSunday (org-read-date nil t "--Sun" nil dayInNextWeek))
       (heading (format "* %s" (format-time-string "%Y")))
       (heading2 (format "** %s (Monday %s - Sunday %s, %s)"
                         (format-time-string "Week %W")
                         (format-time-string "%b %e" thisMonday)
                         (format-time-string "%b %e" thisSunday)
                         (format-time-string "%Y" thisMonday))))
    (save-match-data
      (goto-char (point-min))
      (unless (re-search-forward heading nil 'no-error)
        (end-of-line)
        (newline)
        (insert heading))
      (unless (re-search-forward heading2 nil 'no-error)
        (end-of-line)
        (newline)
        (insert heading2))
      (org-end-of-subtree))))

(setq org-default-notes-file (concat org-directory "notes.org"))
(add-to-list 'org-capture-templates
      `("i" "Internship Thoughts" plain (file+function ,(concat org-directory "/servicenow_2022s.org") yl/find-create-date-entry)
         nil :unnarrowed t :empty-lines 1))

;;
;; Dired
;;

(evil-define-key 'normal dired-mode-map
  "+" nil
  "+f" 'dired-create-empty-file
  "+d" 'dired-create-directory)
