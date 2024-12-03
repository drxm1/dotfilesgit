;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Dominik Rosser"
      user-mail-address "dominik.rosser@protonmail.ch")

;; Set the FiraCode Nerd Font
(setq doom-font (font-spec :family "UDEV Gothic" :size 20)
      doom-variable-pitch-font (font-spec :family "UDEV Gothic" :size 20)
      doom-big-font (font-spec :family "UDEV Gothic" :size 26)
      doom-symbol-font (font-spec :family "UDEV Gothic" :size 20)
      doom-serif-font (font-spec :family "UDEV Gothic" :weight 'light))

;; Doom Theme
(setq doom-theme 'doom-snazzy)

;; Display Line Numbers
                                        ;(setq display-line-numbers-type nil)
(setq display-line-numbers-type 'relative)

;; Org Mode default directory
(setq org-directory "~/org/")

;; Since we have a git repo in our $HOME for the dotfiles,
;; we probably need these tweaks:
(setq projectile-project-search-path
      '("~/.config/hypr/" "~/.config/ags/" "~/.config/nvim/"
        "~/dev" "~/.doom.d/" "~/.dotfiles-nix"))
(after! projectile
  (setq projectile-project-root-files-bottom-up (remove ".git" projectile-project-root-files-bottom-up))
  )

;; Evil Snipe:
;; s for kangaroo jumps with two letters etc.

;; Avy: moving on the screen easily
;; g + s + SPACE
(setq avy-all-windows t)

;; Dired
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file
  )
(after! dired
  (map! :map dired-mode-map
        :n "b" #'browse-url-of-dired-file))

;; Enable IO logging for lsp
(use-package! lsp-mode
  :config
  (setq lsp-log-io t))

;; Typst
;; Load typst-ts-mode for typst files
;; Execute this once:
;;(add-to-list 'treesit-language-source-alist
;;             '(typst "https://github.com/uben0/tree-sitter-typst"))
;;(treesit-install-language-grammar 'typst)
(use-package! typst-ts-mode
  :mode "\\.typ\\'")
(after! typst-ts-mode
  (setq typst-ts-mode-indent-offset 2)
  ;; Add more configuration as needed
  )
;; TODO: This would be added later if I add consult-imenu-config...
;; (setq
;;  consult-imenu-config
;;  (append consult-imenu-config
;;          '((typst-ts-mode :topLevel "Headings" :types
;;             ((?h "Headings" typst-ts-markup-header-face)
;;              (?f "Functions" font-lock-function-name-face))))))

;; Execute this once:
;;(add-to-list 'treesit-language-source-alist
;;             '(wgsl "https://github.com/szebniok/tree-sitter-wgsl"))
;;(treesit-install-language-grammar 'wgsl)
(use-package! wgsl-ts-mode
  :mode "\\.wgsl\\'")

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
;; Nix mode
(use-package! nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . format-all-mode)
  :config
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
  (setq-hook! 'nix-mode-hook
    indent-tabs-mode nil ; Use spaces instead of tabs
    tab-width 2)         ; Set tab width to 2 spaces
  )
;; Nix formatter
(use-package! reformatter
  :config
  (reformatter-define nixfmt
    :program "nixfmt"
    :args '()))
(add-hook 'nix-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'nixfmt-buffer nil t)))

;; Direnv
(use-package! direnv
  :config
  (direnv-mode)
  )

;; Quarto
(use-package! quarto-mode)
(use-package! polymode)
(use-package! poly-markdown)
(use-package! request)
;;; NOTE:
;; if the pull request is confirmed we can:
;; (setq quarto-preview-watch-inputs t)
;; And the preview should reload automatically...
;; For now we have to use quarto preview from the terminal
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

;; PDF configuration
(pdf-tools-install)
(pdf-loader-install)
;; PDF autorealoading
(use-package! pdf-tools
  :config
  (add-hook 'pdf-view-mode-hook 'auto-revert-mode)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-view-use-scaling t
        pdf-view-use-imagemagick nil)
  (defvar my-pdf-revert-attempts 10)
  (defvar my-pdf-revert-interval 0.3)
  (defun my-pdf-view-revert-buffer-repeatedly (buffer attempts)
    (when (and (buffer-live-p buffer) (> attempts 0))
      (with-current-buffer buffer
        (when (eq major-mode 'pdf-view-mode)
          (let ((was-modified (buffer-modified-p))
                (inhibit-message t))
            (pdf-view-revert-buffer nil t)
            (set-buffer-modified-p was-modified))))
      (run-with-timer my-pdf-revert-interval nil
                      #'my-pdf-view-revert-buffer-repeatedly
                      buffer (1- attempts))))
  (defun my-pdf-view-revert-on-save ()
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (eq major-mode 'pdf-view-mode)
          (my-pdf-view-revert-buffer-repeatedly buf my-pdf-revert-attempts)))))
  (add-hook 'after-save-hook #'my-pdf-view-revert-on-save))

;; Window divider configuration
(use-package! framemove
  :config
  (setq framemove-hook-into-windmove t))
