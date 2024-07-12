;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq default-directory "~/Documents/")
(setq doom-file-name-case 'capitalize)
(setq-default tab-width 4)
(setq-default evil-shift-width 4)
(setq-default shift-select-mode t)
(setq-default pc-selection-mode t)
(setq display-line-numbers-type t)
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 14 :weight 'normal))
(setq doom-variable-pitch-font (font-spec :family "Roboto" :size 14 :weight 'normal))
(setq doom-theme 'doom-dracula)
(custom-set-faces
 '(org-link ((t (:underline nil)))))

(setq initial-frame-alist '((left-fringe . 0) (right-fringe . 0)))
(setq default-frame-alist '(
    (left . 1280)
    (top . 30)
    (width . 142)
    (height . 41)
    (internal-border-width . 1)
    (drag-internal-border . 1)
    (user-position . t)
    (undecorated . t)))

(setq dired-find-subdir t) ;stop making new buffers
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

(use-package-hook! evil
  :pre-init
    (setq evil-respect-visual-line-mode t))

(after! treemacs
  (if (eq system-type 'windows-nt)
      (setq treemacs-python-executable "C:\\Python312\\python.exe")
      (setq treemacs-python-executable "/usr/bin/python.exe"))
)

(after! ispell
    (setq ispell-program-name "hunspell")
    (setq ispell-dictionary "en_CA")
    (setq ispell-hunspell-dict-paths-alist
        '(("en_CA" "C:\\Hunspell\\en_CA.aff")
          ("en_CA" "/usr/share/hunspell")))
)

(after! markdown-live-preview
  '(progn
     (setq markdown-live-preview-window-location 'right)))

;;ORG ROAM
(setq org-directory "~/Documents/Notes/")
(setq org-roam-directory "~/Documents/Notes")
(setq org-roam-dailies-directory "~/Documents/Notes/Journal")
(setq org-agenda-files '("~/Documents/Notes/Journal"))
(setq org-roam-completion-everywhere t)

(setq org-roam-capture-templates
       '(("f" "Fleeting" plain (file "./Roaming/Fleeting.org")
           :if-new (file "./Roaming/${title}.org")
           :immediate-finish t
           :jump-to-captured t
           :unnarrowed f)
         ("r" "Reference" plain (file "./References/Reference.org")
           :if-new (file "./References/${title}.org")
           :immediate-finish t
           :jump-to-captured t
           :unnarrowed f)
         ("m" "Map of Content" plain (file "./Concepts/MOP.org")
           :if-new (file "./Concepts/${title}.org")
           :immediate-finish t
           :jump-to-captured t
           :unnarrowed f)
        ))

(setq org-roam-dailies-capture-templates
       '(("j" "Journal" plain " %?"
          :target (file+datetree "%<%Y>.org" day)
          :immediate-finish t
          :jump-to-captured f
          :unnarrowed t)
         ("d" "Dream" entry "%<%d-%b-%Y>\n%?"
          :if-new (file+datetree "Dreams.org" day)
          :immediate-finish t
          :jump-to-captured t
          :unnarrowed f)
        ))

(after! citar
    (setq citar-bibliography '("~/Documents/Notes/References/Zotero.bib"))
    (setq citar-notes-paths '("~/Documents/Notes/References"))
    (setq citar-file-note-extensions '("org" "md"))
    (setq citar-notes-template "")
    (setq bibtex-completion-bibliogrpahy citar-bibliography))

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(defun org-wikipedia-link ()
  "Replace the selected text or word at point with a Wikipedia link."
  (interactive)
  (let* ((word (if (use-region-p)
                   (buffer-substring (region-beginning) (region-end))
                 (thing-at-point 'word)))
         (word (if word (replace-regexp-in-string " " "_" word)
                  (read-string "Enter the word: "))))
        (when word
            (if (use-region-p)
                (delete-active-region)
                (progn (kill-word 1)))
            (insert (format "[[%s][Wikipedia]]" (concat "https://en.wikipedia.org/wiki/" word))))))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
