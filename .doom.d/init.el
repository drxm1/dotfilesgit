;;; init.el -*- lexical-binding: t; -*-
(doom! :input
       ;; ---
       :completion
       company ; code completion backend
       vertico ; 'M-x' completion and narrowing interface for emacs

       :ui
       doom
       (emoji +unicode) ; 🙂
       hl-todo ; TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       indent-guides ; highlighted indent columns
       nav-flash ; blink cursor line after big motions
       ophints ; highlight the region an operation acts on
       unicode ; extended unicode support for various languages
       (popup +all +defaults) ; tame sudden yet inevitable temporary windows
       (vc-gutter +pretty) ; render version control changes in the buffer fringe with icons
       vi-tilde-fringe ; fringe tildes to mark beyond end of buffer
       treemacs ; a project drawer, like neotree but cooler
       workspaces ; tab emulation, persistence & separate workspaces (TODO: how?)
       ligatures ; pretty symbols for function arrows ->, =>, lambda, ...
       window-select ; visually switch windows (TODO: how?)
       ;;hydra ; could be useful to create chains of related commands / keybindings
       ;;zen ; if we ever need a minimal writing/coding environment, use zen to hide UI elements (TODO: how?)

       :editor
       (evil +everywhere) ; vim keybindings
       file-templates ; auto-snippets for empty files
       fold ; (nigh) universal code folding
       (format +onsave) ; automated prettiness
       snippets ; add snippet support

       :emacs
       dired ; making dired pretty [functional]
       undo ; persistent, smarter undo for your inevitable mistakes
       electric ; auto-indentation
       vc ; emacs built-in version control integration
       ;;ibuffer ; interactive buffer management (TODO: how?)

       :term
       eshell              ; the elisp shell that works everywhere (SPC o E)
       vterm               ; the best terminal emulation in Emacs (SPC o T, SPC o t)

       :checkers
       (syntax +childframe)  ; tasing you for every semicolon you forget

       :tools
       (direnv + lsp)
       editorconfig ; .editorconfig support
       (eval +overlay) ; run code, run (also, repls)
       lookup ; navigate your code and its documentation
       (lsp +peek) ; language server protocol integration including "peek to definition"
       magit
       (pdf +viewer)
       tree-sitter ; syntax and parsing

       :os
       (:if (featurep :system 'macos) macos) ; improve compatibility with macOS
       tty ; improve the terminal Emacs experience

       :lang
       (cc +lsp); <-- c
       data; <-- csv, ...
       emacs-lisp
       (haskell +lsp)
       json
       latex
       lua
       markdown
       nix
       org (+roam2)
       (python +cython +lsp +pyright)
       (rust +lsp)
       sh
       yaml

       :config
       ;;literate ; <-- if using a .org file for the emacs config, enable this
       (default +bindings +smartparens))
