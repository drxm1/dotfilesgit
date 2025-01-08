{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # OSK
    wvkbd

    rnote

    # [COMMON] utils, editors, terminal programs, language support, ...
    # not sure if we need all of this but who cares, just keep them all
    vim_configurable
    neovim
    pciutils
    lshw
    kitty
    wget
    os-prober
    gh
    ispell
    udiskie
    udisks2
    arch-install-scripts
    acpi
    gjs
    # gnomeExtensions.eval-gjs had to remove this as it does not seem to exist anymore
    killall
    rsync
    # hollywood
    brightnessctl
    axel
    cpio
    fcitx5
    tree
    glm
    glow
    conky
    tk
    dart-sass
    tinyxml-2
    cargo
    tkimg
    tree-sitter
    silver-searcher
    sassc
    ueberzug
    tesseract
    imagemagick
    inotify-tools
    mdcat
    webp-pixbuf-loader
    gojq
    gcc
    gtk3
    gtk4
    git
    git-extras
    bat
    fd
    catimg
    asciidoctor-with-extensions
    readability-cli
    dhcpcd
    djvulibre
    ffmpegthumbnailer
    efibootmgr
    gparted
    ldc
    lsd
    neofetch
    ack
    cups
    ntfs3g
    rclone
    tmux
    lazygit
    ripgrep
    unzip
    speechd
    signify
    yad
    ydotool
    coreutils
    clang
    pandoc
    shellcheck
    git-crypt
    gnupg
    cmake
    gnumake
    gcc
    libtool

    tree-sitter-grammars.tree-sitter-nix

    # [OS]
    # emacs-git # =emacsGcc (see overlays) installs emacs 28 + native-comp
    emacs30-pgtk

    # The new Typst lsp
    tinymist

    # [WIRELESS] utils, ...
    iw
    iwd
    wpa_supplicant
    # wpa_supplicant_gui

    # [GRAPHICAL] stuff for wayland / hyprland and utils and drivers, nvidia/survace
    libdbusmenu
    libsForQt5.libdbusmenu
    libdbusmenu-gtk3
    libdbusmenu-gtk2
    qt5.qtimageformats
    xwaylandvideobridge
    libsForQt5.layer-shell-qt
    libva
    libwacom-surface
    surface-control
    zenith-nvidia
    # some random drivers might or might not do anything
    # xorg.xf86videointel
    xorg.xf86inputmouse
    xf86_input_wacom
    xorg.xf86videovesa
    # we add some xorg support that might come in handy for some compatibility idk
    xorg.xset
    xorg.xrdb
    xorg.setxkbmap
    xorg.xrandr
    # needed for our sugardark sddm theme:
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects

    # [AUTH KEYRING] polkit, keyring, auth
    polkit_gnome
    gnome-keyring

    # [BLUETOOTH] gnome bluetooth
    gnome-bluetooth
    gnome-bluetooth_1_0
    gnomeExtensions.bluetooth-battery

    # qt6-wayland     -- not found on nixos pkgs

    # useful for calibrating stylus pens
    xinput_calibrator
  ];
}
