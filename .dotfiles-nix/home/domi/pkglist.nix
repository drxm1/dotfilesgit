{ pkgs, inputs, ... }:
let
  #tree-sitter-nix = inputs.tree-sitter-nix-flake.packages.${pkgs.system}.tree-sitter-nix;

  # Latex, compiled so it works with emacs orgmode:
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-basic dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  });
in {
  home.packages = with pkgs; ([
    direnv

    # [LATEX (tex-live)]
    tex

    # [syncthing: for synchronizing files with the phone]
    syncthing

    # [For displaying graph of org-roam]
    graphviz

    # [Pyprland]
    inputs.pyprland.packages."x86_64-linux".pyprland

    # [BROWSERS]
    brave
    firefox
    #firefox-devedition
    qutebrowser
    w3m

    # [FILE MANAGERS]
    nautilus
    nnn
    ranger

    # [GIT UTILS]
    meld

    # [SCREENSHOT AND IMAGE UTILS]
    grim
    slurp
    imagemagick

    # [ISO CREATION UTILS]
    ventoy-full

    # [MEDIA] video, audio, pictures, pdf, ...
    playerctl
    vlc
    kdePackages.okular
    gimp
    zathura
    vimiv-qt

    # [INTERNET] graphical gui tools, utils, vpn, ...
    protonvpn-gui
    iwgtk
    networkmanagerapplet

    # [BLUETOOTH] graphical gui tools
    blueberry
    blueman
    bluedevil
    bluez
    bluez-tools
    bluez-alsa

    # [SOUND] graphical gui tools
    pamixer
    pavucontrol
    pa-notify

    # [APP LAUNCHERS]
    rofi-wayland
    fuzzel
    wofi

    # [PRODUCTIVITY/WORK] apps
    nb
    discord
    p3x-onenote
    libreoffice
    virtualbox
    xournalpp

    # [TERMINAL] prompts, ...
    alacritty
    starship
    fzf
    zoxide
    chroma

    # [GTK]
    adw-gtk3
    gtk3-x11
    gradience

    # [QT]
    kdePackages.qt6gtk2
    qt5ct
    qt6ct
    pinentry-qt

    # [WAYLAND] utils
    cliphist
    slurp
    swaylock
    swww
    waypaper
    swappy
    wlogout
    wlsunset
    wl-gammactl
    wmctrl
    wf-recorder
    grimblast
    eww
    dunst
    wayland-pipewire-idle-inhibit # check if this has a service...
    xclip
    wl-clipboard-rs
    xsel
    wayshot

    # for ags
    ddcutil

    # rust
    rust-analyzer
    llvmPackages.bintools # lld linker
    wasm-pack

    # [EMACS]
    # more treesitter grammars for example tree-sitter-wgsl
    tree-sitter-grammars.tree-sitter-wgsl

    # [HYPRLAND] utils
    hyprshot
    hyprpaper
    hypridle
    hyprcursor
    hyprlock
    hyprpicker

    # [TOOLS]
    chezmoi
    # Print, scan and fax HP drivers for Linux
    hplip

    # Audio
    audacity

    # [WOLFRAM]
    # mathematica TODO

    # [Thunderbird]
    # used for email and tasks-synchronization and maybe also calendar synchronization
    thunderbird

    ledger-live-desktop

    # [TYPST]
    typst
    # vimPlugins.nvim-treesitter-parsers.typst
    typst-lsp
    typst-live
    #typst-preview
    tinymist
    typstfmt
    prettypst
    typst-fmt

    # [Quarto]
    quarto

    # [Additional steam utils]
    steam-tui
    steamcmd

    # [EMACS UTILS]
    nixfmt-classic

    # [PYTHON UTILS AND FORMATTERS]
    black
    python312Packages.cython
    python312Packages.pyflakes
    isort
    python312Packages.pytest
    python311Packages.nose
    python312Packages.pyls-isort
    python312Packages.python-lsp-server
    python312Packages.python-lsp-black
    python312Packages.pylsp-mypy

    # [ICON THEMES]
    gnome-icon-theme
    papirus-icon-theme
    numix-icon-theme
    iconpack-obsidian
    iconpack-jade
    icon-library
    material-icons
    material-design-icons
    material-symbols
    papirus-icon-theme

    # [FONTS]
    jetbrains-mono
    victor-mono
    udev-gothic
    iosevka
    rubik
    lexend
    nerdfonts

    # [STEAM]
    protonup-qt

    lxqt.lxqt-openssh-askpass # GUI to query passwords on behalf of SSH agents.

    python311Packages.material-color-utilities
    python311Packages.matplotlib
    # python311Packages.pipx
    pipx
    pywal
    python311Packages.pywayland
    python311Packages.setuptools-scm
    pyright

    vimPlugins.coc-pyright # probably only need the one from nodePackages... maybe remove

    # asztal
    bun

    kdePackages.plasma-wayland-protocols

  ]);
}
