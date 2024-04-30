{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    inputs.pyprland.packages."x86_64-linux".pyprland
    
    # [BROWSERS]
    brave	firefox qutebrowser w3m

    # [FILE MANAGERS]
    gnome.nautilus nnn ranger
    
    # [GIT UTILS]
    meld

    # [MEDIA] video, audio, pictures, pdf, ...
    vlc kdePackages.okular gimp zathura vimiv-qt

    # [INTERNET] graphical gui tools, utils, vpn, ...
    protonvpn-gui iwgtk networkmanagerapplet

    # [BLUETOOTH] graphical gui tools
    blueberry blueman bluedevil bluez bluez-tools bluez-alsa

    # [SOUND] graphical gui tools
    pamixer pavucontrol pa-notify

    # [APP LAUNCHERS]
    rofi-wayland fuzzel wofi
    
    # [PRODUCTIVITY/WORK] apps
    nb discord p3x-onenote libreoffice virtualbox xournalpp

    # [TERMINAL] prompts, ...
    alacritty starship

    # [GTK]
    adw-gtk3 gtk3-x11 gradience

    # [QT]
    kdePackages.qt6gtk2 qt5ct qt6ct

    # [WAYLAND] utils
    cliphist slurp swaylock swww waypaper swappy
    wlogout wlsunset wl-gammactl wmctrl wf-recorder grimblast eww dunst
    wayland-pipewire-idle-inhibit # check if this has a service...
    xclip wl-clipboard-rs xsel wayshot

    # [HYPRLAND] utils
    hyprshot hyprpaper hypridle hyprcursor hyprlock hyprpicker

    # [TOOLS]
    chezmoi
    hplip		# Print, scan and fax HP drivers for Linux

    # [TYPST]
    typst vimPlugins.nvim-treesitter-parsers.typst typst-lsp typst-live
    typst-preview typstfmt prettypst typst-fmt

    # [NVIM] utils / libraries mainly used for nvim
    # ...

    # [ICON THEMES]
    gnome-icon-theme papirus-icon-theme numix-icon-theme iconpack-obsidian iconpack-jade
    icon-library material-icons material-design-icons material-symbols papirus-icon-theme

    # [FONTS]
    jetbrains-mono victor-mono udev-gothic iosevka rubik lexend nerdfonts

    # [STEAM]
    protonup-qt


    lxqt.lxqt-openssh-askpass # GUI to query passwords on behalf of SSH agents.

    python311Packages.material-color-utilities python311Packages.matplotlib
    python311Packages.pipx pipx pywal python311Packages.pywayland
    python311Packages.setuptools-scm nodePackages.pyright


    vimPlugins.coc-pyright # probably only need the one from nodePackages... maybe remove
    # REM30 smplayer  # A complete front-end for MPlayer

    # REM30 xdg-desktop-portal-hyprland
    # REM30 libsForQt5.xdg-desktop-portal-kde

    #zoom-us issues not free TODO
    # asztal
    bun
    # TODO: zathura-pdf-poppler

    # x11_ssh_askpass

    ### KDE STUFF ### 
    # REM30 spectacle
    # REM30 plasma-browser-integration

    kdePackages.plasma-wayland-protocols

    # REM30 polkit-kde-agent
  ];
}
