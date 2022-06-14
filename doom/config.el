;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


(setq user-full-name "Yunlan Li"
      user-mail-address "yl4387@columbia.edu")
(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)


;;
;; Key Bindings
;;

(map!
 :leader "f t"  'neotree
 :leader ">"    'eshell
 :leader "e e"  'er/expand-region)


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

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))


;;
;; Org Capture
;;

(defun yl/find-create-week-entry ()
  "Append to end of or create Org entry with date heading."
  (let*
      (
       (dayInLastWeek (org-read-date nil t "-7d"))
       (dayInNextWeek (org-read-date nil t "+7d"))
       (thisMonday (org-read-date nil t "++Mon" nil dayInLastWeek))
       (thisSunday (org-read-date nil t "--Sun" nil dayInNextWeek))
       (heading (format "* %s" (format-time-string "%Y" thisMonday)))
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
      `("i" "Internship Thoughts" plain (file+function ,(concat org-directory "/servicenow_2022s.org") yl/find-create-week-entry)
         nil :unnarrowed t :empty-lines 1))
(add-to-list 'org-capture-templates
      `("w" "Weekly Review" plain (file+function ,(concat org-directory "/weekly.org") yl/find-create-week-entry)
         nil :unnarrowed t :empty-lines 1))

;;
;; Dired
;;

(evil-define-key 'normal dired-mode-map
  "+" nil
  "+f" 'dired-create-empty-file
  "+d" 'dired-create-directory)


;;
;; LSP
;;

(require 'lsp-mode)
(require 'lsp-ui)
(require 'lsp-ui-doc)

(defun yl/toggle-lsp-ui-imenu ()
  "Toggle lsp-ui-imenu."
  (interactive)
  (let
      ((imenu-buffer (get-buffer "*lsp-ui-imenu*")))
    (if imenu-buffer
        (evil-delete-buffer imenu-buffer)
      (lsp-ui-imenu))))

(defun yl/toggle-lsp-ui-doc ()
  "Toggle lsp-ui-doc."
  (interactive)
  (if lsp-ui-doc-mode
      (lsp-ui-doc-hide)
    (lsp-ui-doc-show)))

(defun yl/lsp-go-install-save-hooks ()
  "Hooks for go-mode."
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(map!
 :leader :desc "Jump to definition" "c d" #'lsp-ui-peek-find-definitions
 :leader :desc "Jump to reference" "c D" #'lsp-ui-peek-find-references
 :leader :desc "Toggle lsp-ui-imenu" "c m" #'yl/toggle-lsp-ui-imenu
 :leader :desc "Jump to symbol (file)" "c j" #'consult-lsp-file-symbols
 :leader :desc "Jump to symbol (workspace)" "c J" #'lsp-ivy-workspace-symbol
 :leader :desc "Toggle lsp-ui-doc" "c k" #'yl/toggle-lsp-ui-doc)

(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

(setq lsp-ui-doc-show-with-cursor nil
      lsp-ui-doc-position 'top)

(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook #'yl/lsp-go-install-save-hooks)


(lsp-register-custom-settings
 '(("gopls.completeUnimported" t t)
   ("gopls.staticcheck" t t)))