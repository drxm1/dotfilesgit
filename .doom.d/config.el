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

;; Typst
; Load typst-ts-mode for typst files
(use-package! typst-ts-mode
  :mode "\\.typ\\'")
(after! typst-ts-mode
  (setq typst-ts-mode-indent-offset 2)
  ;; Add more configuration as needed
  )
