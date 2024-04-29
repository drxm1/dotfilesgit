{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.pyprland.packages."x86_64-linux".pyprland

    brave		# Our main browser of choice.
    firefox		# Our secondary browser
    qutebrowser		# Browser with vim hotkeys.
    meld # graphical diff and merge tool

    protonvpn-gui

    xwaylandvideobridge

    # temporary we need this here:
    nb
    onboard
    arch-install-scripts # arch-chroot included...
    kdePackages.okular

    vlc

    gjs
    gnomeExtensions.eval-gjs
    hollywood
    brightnessctl	# Terminal program to control screen brightness.
    killall
    discord
    acpi
    adw-gtk3
    catimg
    gtk3-x11
    cargo       # TODO: should probably install this in shell via rustup...
    # thunar		# Thunar was already enabled in configuration.nix
    asciidoctor-with-extensions
    axel # Console downloading program with some features for parallel connections
    blueberry # Bluetooth configuration tool
    blueman # GTK-based Bluetooth Manager
    cliphist # A wayland clipboard manager
    conky
    cpio
    dart-sass # sass implementation
    #discord issues because not free
    fcitx5 # probably not needed, provides language support for chinese etc.
    foot # some wayland terminal emulator idk what it does
    rofi-wayland # look online it has a lot of menus other people built with it.
    fuzzel # Wayland-native application launcher, similar to rofi's drun mode
    gimp
    glm # OpenGL Mathematics library for C++ idk why I would need that but whatever, had it on arch previously
    glow # Render markdown on the CLI, with pizzazz!
    gnome.gnome-bluetooth
    gnome.gnome-control-center
    gnome.gnome-keyring
    rsync
    silver-searcher
    tinyxml-2 # A simple, small, efficient, C++ XML parser
    tk
    tkimg
    tree-sitter
    tree
    # TODO: rustup
    jetbrains-mono # FONT
    victor-mono # Programming font with cursive italics and ligatures
    udev-gothic # Programming font that combines BIZ UD Gothic and JetBrains Mono
    iosevka # font
    material-symbols
    material-icons
    material-design-icons
    icon-library
    udiskie
    w3m
    ueberzug
    rubik
    sassc
    starship # A minimal blazing fast and extremely customizable prompt for any shell TODO: ???
    # TODO: steam
    # matugen ???
    slurp # Select a region in a wayland compositor
    swappy # A wayland native snapshot editing tool, inspired by snappy on macOS
    swww # another wallpaper daemon
    waypaper # yet another wallpaper daemon
    tesseract # OCR engine ??????
    system-config-printer
    qt5.qtimageformats
    swaylock # swaylock-effects, swaylock-fancy
    hyprcursor # only available on unstable!!!
    hyprpaper
    hyprpicker
    #hyprland-protocols
    #hyprland
    hyprshot
    hyprlock
    hypridle
    # TODO: hyprland-activewindow !!!
    imagemagick
    inotify-tools
    iw
    iwd
    iwgtk # Lightweight, graphical wifi management utility for Linux
    lexend # A variable font family designed to aid in reading proficiency
    mdcat # cat for markdown
    gnome.nautilus # The file manager for GNOME
    networkmanagerapplet # NetworkManager control applet for GNOME
    readability-cli
    lxqt.lxqt-openssh-askpass # GUI to query passwords on behalf of SSH agents.
    pamixer
    papirus-icon-theme
    pavucontrol
    pa-notify # PulseAudio or PipeWire volume notification
    wayland-pipewire-idle-inhibit # Suspends automatic idling of Wayland compositors when media is being played through Pipewire.
    polkit_gnome # A dbus session bus service that is used to bring up authentication dialogs
    protonup-qt # Install and manage Proton-GE for Steam with this graphical user interface
    python311Packages.material-color-utilities
    python311Packages.matplotlib
    python311Packages.pipx
    pipx
    pywal
    python311Packages.pywayland
    python311Packages.setuptools-scm
    xdg-desktop-portal-gtk
    webp-pixbuf-loader
    wf-recorder
    wl-gammactl
    wlogout
    wlsunset
    wmctrl
    wvkbd

    # x11_ssh_askpass

    # jupyterlab, jupyter-notebook are in the shell.nix files for each project!

    # Funny cursors:
    # comixcursors, banana-cursor
    # multicursors.nvim
    # hyprlandPlugins.hy3
    # hyprland-per-window-layout
    # hyprland-autoname-workspaces -- Automatically rename workspaces with icons of started applications
    # hyprshade
    # hyprkeys
    # hyprnome
    # hyprdim
    # nwg-displays
    gojq # Some maybe useful terminal command...
    gradience # Customize libadwaita and GTK3 apps (with adw-gtk3)
    grimblast # might be called grimblast-unstable in the teminal...
    git
    git-extras		# git-delta etc.
    nerdfonts
    gcc
    gtk3
    gtk4
    eww 		# idk if we should add it here as well since we already enable it with home manager
    alacritty		# Another terminal application like kitty.
    bat			# ??? probably needed for something.
    fd
    # BLUETOOTH
    bluedevil		# Bluetooth ???something???
    bluez
    bluez-tools
    bluez-alsa
    chezmoi		# Used this for the dotfiles of arch previously.
    cups		# ???
    dhcpcd		# ???
    djvulibre		# DJVU file support
    ffmpegthumbnailer
    # dksm ??? needed ??? it does not exist
    dunst		# A notification manager.
    efibootmgr		# A Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot manager. TODO: Do we need this???
    gparted
    hplip		# Print, scan and fax HP drivers for Linux
    lazygit
    ldc			# D compiler
    lsd			# ls with colors
    neofetch
    ack
    nnn			# File manager TODO: can be enabled with home-manager as well
    # nnn-icons		does not seem to exist on nixos pkgs
    ranger  # File manager TODO: can be enabled with home-manager as well
    ntfs3g		# FUSE-based NTFS driver with full write support
    p3x-onenote # Linux Electron Onenote - A linux compatible version of OneNote
    nodePackages.pyright
    vimPlugins.coc-pyright # probably only need the one from nodePackages... maybe remove
    # TODO: i dont know how we should use or install pip on nix, but lets do it like this for now:
    # python312Packages.pip
    # python312Packages.pyqt6
    kdePackages.qt6gtk2
    qt5ct
    qt6ct
    rclone
    # drun
    libreoffice
    ripgrep
    signify
    smplayer  # A complete front-end for MPlayer
    # TODO: snapd -- integrating snap into nixos requires additional configuration
    speechd # speech-dispatcher
    tmux # TODO: nixos provides options, or also home-manager. We could control it with that.
    # Typst. note it has even more stuff for vscode as well on nixpkgs
    typst
    vimPlugins.nvim-treesitter-parsers.typst
    typst-lsp
    typst-live
    typst-preview
    typstfmt
    prettypst
    typst-fmt
    unzip
    vimiv-qt
    virtualbox
    wl-clipboard-rs
    xclip
    xdg-desktop-portal-hyprland
    libsForQt5.xdg-desktop-portal-kde
    wayshot # yet another screenshot tool (wlroots based such as sway and river)
    yad
    ydotool
    #zoom-us issues not free TODO
    # asztal
    bun
    # some random drivers might or might not do anything
    xorg.xf86videointel
    xorg.xf86inputmouse
    xf86_input_wacom
    xorg.xf86videovesa
    # we add some xorg support that might come in handy for some compatibility idk
    xorg.xset xorg.xrdb xorg.setxkbmap xorg.xrandr
    # xorg.xwayland -- enabled elsewhere
    wofi # can also be configured using home-manager
    xsel
    xournalpp
    zathura
    # TODO: zathura-pdf-poppler

    ### KDE STUFF ### 
    spectacle # Screenshot utility from kde. dunno if it works here, should maybe test it
    ### as well as some other things that were in pkglist.txt
    # kdePackages.flatpak-kcm
    # libsForQt5.flatpak-kcm
    # bluez-utils	# Bluetooth we had this on arch. does not exist.
    # github-cli
    # grub
    # gvfs		or services.gvfs.enable ??? TODO: ??? or gnome.gvfs or gnome2.gvfs
    # icons-in-terminal-git
    # kactivitymanagerd
    # kde-cli-tools
    # kde-gtk-config
    # kdecoration
    # kdeplasma-addons
    # kgamma
    # khotkeys
    # kinfocenter
    # kmenuedit
    # konsole
    # kpipewire		# not needed but TODO: Make sure we have pipewire!
    # kscreen
    # kscreenlocker
    # ksystemstats
    # libkscreen
    # libksysguard
    # milou
    # oxygen
    # plasma-desktop
    # plasma-workspace
    # plasma-integration
    # plasma-nm
    # plasma-pa
    # plasma-thunderbolt
    plasma-systemmonitor
    kdePackages.plasma-disks
    # plasma-sdk
    plasma-browser-integration
    # plasma-pa
    # plasma-mobile
    kdePackages.plasma-wayland-protocols
    # plymouth-kcm
    polkit-kde-agent
    # powerdevil
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
