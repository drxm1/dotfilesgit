;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Dominik Rosser"
      user-mail-address "dominik.rosser@protonmail.ch")

;; FONT
(setq doom-font (font-spec :family "UDEV Gothic" :size 20)
      doom-variable-pitch-font (font-spec :family "UDEV Gothic" :size 20)
      doom-big-font (font-spec :family "UDEV Gothic" :size 26)
      doom-symbol-font (font-spec :family "UDEV Gothic" :size 20)
      doom-serif-font (font-spec :family "UDEV Gothic" :weight 'light))

;; CURSOR
(setq x-pointer-shape nil)
(setq x-pointer-foregroud-color "black")
(setq x-pointer-background-color "white")

;; THEME
(setq doom-theme 'doom-pine) ; doom-flatwhite,leuven-dark,doom-snazzy, doom-one

;; QUICK CONFIG ONELINERS
(setq comp-deferred-compilation t) ; native compilation speeds things up a bit
(setq async-bytecomp-allowed-packages '(all)) ; async package loading is faster
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer) ; less initial dashboard loading
(setq confirm-kill-emacs nil)
(setq display-line-numbers-type 'relative) ; nil
(after! lsp-mode (setq lsp-log-io t)) ; enable IO logging for lsp
(setq avy-all-windows t) ; move to words with 'g-s-SPC'

;; PROJECTILE
(setq projectile-project-search-path
      '("~/.config/hypr/" "~/.config/ags/" "~/.config/nvim/"
        "~/dev" "~/.doom.d/" "~/.dotfiles-nix"))
(after! projectile (setq projectile-project-root-files-bottom-up (remove ".git" projectile-project-root-files-bottom-up))) ; since we have --bare repo in $HOME we need to tweak this

;; DIRED
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file)

;; Typst
;; Execute this once 'SPC-o-E':
;; (add-to-list 'treesit-language-source-alist '(typst "https://github.com/uben0/tree-sitter-typst"))
;; (treesit-install-language-grammar 'typst)
(use-package! typst-ts-mode :mode "\\.typ\\'")
(after! typst-ts-mode
  (setq typst-ts-mode-indent-offset 2)
  ;; TODO: maybe need to add some other stuff if we choose to add consult-imenu-config
  )

;; Execute this once 'SPC-o-E':
;; (add-to-list 'treesit-language-source-alist '(wgsl "https://github.com/szebniok/tree-sitter-wgsl"))
;; (treesit-install-language-grammar 'wgsl)
(use-package! wgsl-ts-mode
  :mode "\\.wgsl\\'")

;; VTERM
(use-package! vterm
  :commands vterm
  :config
  ;; Set the default shell to the user's shell;
  (setq vterm-shell "/run/current-system/sw/bin/zsh"))
(map! :leader
      :desc "Open vterm" "o t" #'vterm)

;; Nix language support
(use-package! tree-sitter-langs :after tree-sitter)

;; Nix mode
(use-package! nix-mode
  :mode "\\.nix\\'"
  :config
  (setq-hook! 'nix-mode-hook indent-tabs-mode nil tab-width 2))

;; Direnv - should be enabled by init.el...
;; (use-package! direnv :config (direnv-mode))

;; PDF autorealoading
(use-package! pdf-tools
  :defer t
  :config
  (pdf-loader-install)
  (add-hook 'pdf-view-mode-hook 'auto-revert-mode)
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-view-use-scaling t
        pdf-view-use-imagemagick nil)
  ;; Some weird script that seems to help autoreloading pdf on every change like in 'typst watch'
  (defvar my-pdf-revert-attempts 10)
  (defvar my-pdf-revert-interval 0.3)
  (defun my-pdf-view-revert-buffer-repeatedly (buffer attempts)
    (when (and (buffer-live-p buffer) (> attempts 0))
      (with-current-buffer buffer
        (when (derived-mode-p 'pdf-view-mode)
          (let ((was-modified (buffer-modified-p))
                (inhibit-message t))
            (pdf-view-revert-buffer nil t)
            (set-buffer-modified-p was-modified))))
      (run-with-timer my-pdf-revert-interval nil
                      #'my-pdf-view-revert-buffer-repeatedly
                      buffer (1- attempts))))
  ;;
  (defvar my-pdf-revert-timer nil)
  (defun my-pdf-view-revert-on-save ()
    (when (derived-mode-p 'pdf-view-mode)
      (when (timerp my-pdf-revert-timer)
        (cancel-timer my-pdf-revert-timer))
      (setq my-pdf-revert-timer
            (run-with-timer
             0 nil #'my-pdf-view-revert-buffer-repeatedly
             (current-buffer) my-pdf-revert-attempts))))
  ;;
  (add-hook 'after-save-hook #'my-pdf-view-revert-on-save))

;; Window divider configuration
(use-package! framemove :config (setq framemove-hook-into-windmove t))

;; Rainbow-Delimiters configuration
(use-package! rainbow-delimiters :hook (prog-mode . rainbow-delimiters-mode))

;; Orderless is a flexible completion style in 'M-x':
;; - You can type multiple space-separated substrings to match in any order.
;; - Example: typing 'ff bu' might fuzzy-match 'buffer-file-format' because it contains 'ff' and 'bu'
;; Keybindings: None.
(use-package! orderless
  :when (modulep! :completion vertico) ;; only load if using vertico
  :init
  ;; Configure the completion styles
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        ;; enable partion-completion for file paths:
        completion-category-overrides '((file (styles orderless partial-completion)))))

;; Marginalia adds better annotations to completion candidates in 'M-x'
;; Keybindings: None.
(use-package! marginalia
  :after vertico
  :init
  (marginalia-mode))

;; COMPANY BOX
(use-package! company-box
  :hook (company-mode . company-box-mode)
  :init
  ;; If you want the documentation popup:
  (setq company-box-doc-enable t)
  :config
  ;; Optional: tweak popup settings
  (setq company-box-doc-delay 0.3
        company-box-doc-frame-parameters '((internal-border-width . 1)
                                           (left-fringe . 8)
                                           (right-fringe . 8))))
