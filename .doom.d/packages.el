;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! typst-ts-mode :recipe (:host sourcehut :repo "meow_king/typst-ts-mode")) ; typst
(package! wgsl-ts-mode :recipe (:host sourcehut :repo "acowley/wgsl-ts-mode")) ; wgsl / wgpu
(package! nix-ts-mode) ; better nix support - not part of :lang nix in doom yet
(package! framemove) ; resize windows a bit easier
(package! tree-sitter-langs) ; treesitter languages installation
(package! rainbow-delimiters) ; color-coded parentheses
(package! orderless)
(package! marginalia)
(package! company-box)
