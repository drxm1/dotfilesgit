;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq user-full-name "Dominik Rosser"
      user-mail-address "dominik.rosser@protonmail.ch")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face

;; Set the FiraCode Nerd Font
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 20)
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 26)
      doom-symbol-font (font-spec :family "FiraCode Nerd Font" :size 20)
      doom-serif-font (font-spec :family "FiraCode Nerd Font" :weight 'light))
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; Doom Theme
                                        ;(setq doom-theme 'doom-one)            ; 2
                                        ;(setq doom-theme 'doom-city-lights)    ; 2
                                        ;(setq doom-theme 'doom-1337)           ; 2
                                        ;(setq doom-theme 'doom-moonlight)       ; 4
                                        ;(setq doom-theme 'doom-nord)           ; 3
                                        ;(setq doom-theme 'doom-outrun-electric) ; 4
(setq doom-theme 'doom-snazzy)          ; 4.2

;; Display Line Numbers
(setq display-line-numbers-type nil);'relative)

;; Org Mode default directory
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.after.
;;
;;   (g! PACKAGE
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



;;
;; Since we have a git repo in our $HOME for the dotfiles,
;; we probably need these tweaks:
(setq projectile-project-search-path
      '("~/.config/hypr/" "~/.config/ags/" "~/.config/nvim/"
        "~/dev" "~/.doom.d/"))
(after! projectile
                                        ;(add-to-list 'projectile-project-root-files-bottom-up ".git")
                                        ;(add-to-list 'projectile-project-root-files-bottom-up ".gitignore")
  (setq projectile-project-root-files-bottom-up (remove ".git" projectile-project-root-files-bottom-up))
                                        ;(setq projectile-project-root-files-bottom-up (remove ".gitignore" projectile-project-root-files-bottom-up))
                                        ;(add-to-list 'projectile-ignored-projects "~/")
                                        ;(setq projectile-ignored-project-function
                                        ;     (lambda (project-root)
                                        ;        (equal project-root (expand-file-name "~/"))))
  )

;; TODO / FIXME


;; Typst Support


;; Emacs Doom E06 - evil snipe: quick horizontal movements
;; s for kangaroo jumps with two letters etc.
;; ALREADY ENABLED...

;; Emacs Doom E07 - avy: moving the screen easily
;; g + s + SPACE ...
(setq avy-all-windows t)

;; Dired
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
                                        ;(kbd "l") 'dired-open-file
  )
(after! dired
  (map! :map dired-mode-map
        :n "b" #'browse-url-of-dired-file))

;; Enable IO logging for lsp
(use-package! lsp-mode
  :config
  (setq lsp-log-io t))

;; Typst
                                        ; Load typst-ts-mode for typst files
(use-package! typst-ts-mode
  :mode "\\.typ\\'")
(after! typst-ts-mode
  (setq typst-ts-mode-indent-offset 2)
  ;; Add more configuration as needed
  )

;; Vterm
(use-package! vterm
  :commands vterm
  :config
  ;; Set the default shell to the user's shell;
  (setq vterm-shell "/run/current-system/sw/bin/zsh");(getenv "SHELL"))
  )
(map! :leader
      :desc "Open vterm" "o t" #'vterm)

;; Nix language support
(use-package! tree-sitter-langs
  :ensure t
  :after tree-sitter)
;; (use-package! nix-ts-mode
;;   :ensure t
;;   :mode "\\.nix\\'"
;;   :config
;;   ;; Ensure tree-sitter uses the custom grammar path
;;   (add-to-list 'auto-mode-alist '("\\.nix\\' . nix-ts-mode"))
;;   )
(use-package! nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . format-all-mode)
  :config
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
  (setq-hook! 'nix-mode-hook
    indent-tabs-mode nil ; Use spaces instead of tabs
    tab-width 2)         ; Set tab width to 2 spaces
  )
(use-package! reformatter
  :config
  (reformatter-define nixfmt
    :program "nixfmt"
    :args '()))
(add-hook 'nix-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'nixfmt-buffer nil t)))

;; Direnv auto switch shell (used alongside lorri: 'lorri init' for new project)
(use-package! direnv
  :config
  (direnv-mode)
  ;; Add a hook to reload LSP after direnv is done
  (add-hook 'direnv-env-changed-hook #'lsp-restart-workspace)
  )

;; Quarto
(use-package! quarto-mode)
(use-package! polymode)
(use-package! poly-markdown)
(use-package! request)
;;; NOTE:
                                        ; if the pull request is confirmed we can:
                                        ; (setq quarto-preview-watch-inputs t)
                                        ; And the preview should reload automatically...
                                        ; For now we have to use quarto preview from the terminal
;;; Auto reload buffer for qmd files at least on save.
;;; TODO


;; Org-Roam
(use-package! org)

;; Define a function to insert `#+STARTUP: latexpreview` at the beginning of a new Org file
(defun my/org-mode-setup ()
  "Insert `#+STARTUP: latexpreview` at the beginning of a new Org file."
  (when (and (string-equal (file-name-extension (or buffer-file-name "")) "org")
             (= (point-min) (point-max)))
    (insert "#+STARTUP: latexpreview\n\n")))
;; Add the function to the Org-mode hook
(add-hook 'org-mode-hook 'my/org-mode-setup)

(use-package! org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-enable)
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  )
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
(setq org-image-actual-width 600)
;; Org-Roam-UI
(use-package! websocket
  :after org-roam)
(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
