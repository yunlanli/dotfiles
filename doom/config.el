;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


(setq user-full-name "Yunlan Li"
      user-mail-address "yl4387@columbia.edu")
(setq doom-theme 'doom-gruvbox-light)
(setq display-line-numbers-type 'relative)

(add-to-list 'exec-path
             (concat (getenv "HOME") "/.stack/programs/aarch64-osx/ghc-9.0.2/bin"))
(setq envrc-direnv-executable "/opt/homebrew/bin/direnv")

;;
;; e-shell
;;

(defun shortened-path (path)
  (let ( (components (split-string path "/")) )
    (if (or (length< components 3)
            (and (length= components 4) (string= (substring path 0 1) "/")))
        path
        (mapconcat 'identity (seq-subseq components -3) "/"))))

(setq eshell-prompt-function (lambda nil
        (concat "λ " (shortened-path (eshell/pwd)) " ❯ ")))

(setq eshell-prompt-regexp "^λ [^λ❯ ]+ ❯ ")

(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell '-1))


;;
;; Key Bindings
;;

(map!
 :leader "f t"  'neotree
 :leader ">"    'eshell
 :leader "e e"  'er/expand-region)

;;
;; Roam
;;

(after! org-roam
  (map!
   :leader
   :prefix ("r" . "org-roam")
   :desc   "find node and open"     "o" #'org-roam-node-find
   :desc   "insert node at point"   "i" #'org-roam-node-insert
   :desc   "capture new or existing node" "c" #'org-roam-capture

   :prefix ("r a" . "node alias")
   :desc "add alias"     "a" #'org-roam-alias-add
   :desc "delete alias"  "d" #'org-roam-alias-remove

   :prefix ("r r" . "node reference")
   :desc "add reference"        "a" #'org-roam-ref-add
   :desc "delete reference"     "d" #'org-roam-ref-remove

   :prefix ("r u" . "roam ui")
   :desc "open org-roam-ui webpage"     "o" #'org-roam-ui-open))


;;
;; Olivetti
;;

(use-package olivetti
  :init
  (setq olivetti-body-width 100))


;;
;; Org Mode
;;

(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)

  (setq
   org-directory  "~/Dropbox/Emacs/org/"
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
(setq-default fill-column 85)
(add-hook 'org-mode-hook 'auto-fill-mode)

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))

(setq-default doom-scratch-initial-major-mode 'org-mode)

;;
;;  Org Roam
;;

(setq org-roam-directory (file-truename "~/Dropbox/Emacs/org-roam"))
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
        nil :unnarrowed t :empty-lines 1)
      `("c" "PPS Meeting Notes" plain (file+function ,(concat org-directory "/pps_meeting_notes.org") yl/find-create-week-entry)
        nil :unnarrowed t :empty-lines 1)
      )
(add-to-list 'org-capture-templates
             `("r"
               "Reading Notes"
               entry
               (file ,(concat org-directory "/reading_notes.org"))
               "* %^{Book|APUE|OSTEP} - %^{Chapter / Topic}\n\n(%t)\n%i%?\n\n"))

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
 :leader :desc "Show lsp-ui-doc" "c k" #'lsp-ui-doc-show
 :leader :desc "Hide lsp-ui-doc" "c K" #'lsp-ui-doc-hide)

(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

(setq lsp-ui-doc-show-with-cursor nil
      lsp-ui-doc-position 'top)

;; Go
(setq lsp-go-env '((GOFLAGS . "-tags=unit_test,integration_test")))

(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook #'yl/lsp-go-install-save-hooks)


(lsp-register-custom-settings
 '(("gopls.completeUnimported" t t)
   ("gopls.staticcheck" t t)))

;; Python
;; (use-package lsp-pyright
;;   :ensure t
;;   :hook (python-mode . (lambda ()
;;                           (require 'lsp-pyright)
;;                           (lsp))))  ; or lsp-deferred

;; Haskell
;;
(require 'lsp)
(require 'lsp-haskell)
;; Hooks so haskell and literate haskell major modes trigger LSP setup
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

;;
;; DAP
;;

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

(require 'dap-dlv-go)
