# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config,lib,pkgs,inputs,... }:

{
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "sg";

  imports = [
      ./hardware-configuration.nix # never remove this
      ./hardware/nvidia.nix
      ./system/nvidia.nix
      ./system/steam.nix
      ./system/onedrive.nix
      ./system/opencl_compute.nix
      ./system/bootloader.nix
      ./system/bluetooth_and_sound.nix
      ./system/themes/sddm-theme.nix
    ];

  services.flatpak.enable = true; # for scrivano application download needed
  services.upower.enable = true; # for ags needed
  services.udisks2.enable = true;
  # REM30 services.emacs = {
  # REM30  enable = true;
  # REM30 package = pkgs.emacs;
  # REM30 };
  systemd.user.services.udiskie = { description = "Automount service using udiskie for user devices";
    after = [ "graphical-session-pre.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.udiskie}/bin/udiskie -A -n";
      Restart = "always";
    };
  };
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  services.xserver = {
    xkb.layout = "ch";
    xkb.variant = "";
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      ## do not add this: pkgs.xdg-desktop-portal-hyprland  (it is already included)
    ];
    wlr.enable = true; # screen sharing
  };
  systemd.user.services.xdg-desktop-portal-hyprland = {
    wantedBy = [ "xdg-desktop-portal.service" ];
    before = [ "xdg-desktop-portal.service" ];
  };
  users.users.domi = {
    isNormalUser = true;
    description = "domi";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    packages = with pkgs; [];
    shell = pkgs.bash;
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
        sha256 = "0pl7rphx1idq4b8v3w2jarxqiwqvgrkw9m7a6jwhx2ani5pcpn32";
      }))
  ];

  # Shells
  environment.shells = with pkgs; [ bash zsh ];
  #users.defaultUserShell = pkgs.zsh;
  users.defaultUserShell = pkgs.bash;
  programs.zsh.enable = true;
  environment.variables.EDITOR = "nvim";
  fileSystems."/" = {
    device = lib.mkDefault "/dev/nvme0n1p3";
    fsType = lib.mkDefault "ext4";
  };
  fileSystems."/boot" = {
    device = lib.mkDefault "/dev/nvme0n1p1"; fsType = lib.mkDefault "vfat";
  };
  environment.systemPackages = with pkgs; [
      # [COMMON] utils, editors, terminal programs, language support, ...
      # not sure if we need all of this but who cares, just keep them all
      vim_configurable neovim pciutils lshw kitty wget os-prober gh udiskie udisks2
      arch-install-scripts acpi gjs gnomeExtensions.eval-gjs killall rsync hollywood
      brightnessctl axel cpio fcitx5 tree glm glow conky tk dart-sass tinyxml-2 cargo
      tkimg tree-sitter silver-searcher sassc ueberzug tesseract imagemagick
      inotify-tools mdcat webp-pixbuf-loader gojq gcc gtk3 gtk4 git git-extras
      bat fd catimg asciidoctor-with-extensions readability-cli dhcpcd djvulibre
      ffmpegthumbnailer efibootmgr gparted ldc lsd neofetch ack cups ntfs3g rclone
      tmux lazygit ripgrep unzip speechd signify yad ydotool coreutils clang
      pandoc shellcheck git-crypt gnupg

      # [OS]
      emacs-git # =emacsGcc (see overlays) installs emacs 28 + native-comp

      # [WIRELESS] utils, ...
      iw iwd
      wpa_supplicant wpa_supplicant_ro_ssids wpa_supplicant_gui

      # [GRAPHICAL] stuff for wayland / hyprland and utils and drivers, nvidia/survace
      libdbusmenu libsForQt5.libdbusmenu libdbusmenu-gtk3 libdbusmenu-gtk2
      qt5.qtimageformats
      xwaylandvideobridge libsForQt5.layer-shell-qt
      libva libwacom-surface surface-control zenith-nvidia
      # some random drivers might or might not do anything
      xorg.xf86videointel xorg.xf86inputmouse xf86_input_wacom xorg.xf86videovesa
      # we add some xorg support that might come in handy for some compatibility idk
      xorg.xset xorg.xrdb xorg.setxkbmap xorg.xrandr
      # needed for our sugardark sddm theme:
      libsForQt5.qt5.qtquickcontrols2 libsForQt5.qt5.qtgraphicaleffects

      # [AUTH KEYRING] polkit, keyring, auth
      polkit_gnome gnome.gnome-keyring

      # [BLUETOOTH] gnome bluetooth
      gnome.gnome-bluetooth gnome.gnome-bluetooth_1_0 gnomeExtensions.bluetooth-battery
      
      

      ### KDE STUFF THAT MIGHT BE USEFUL ###
      # REM30.4 kdePackages.kwallet kdePackages.kwalletmanager kwallet-pam kwalletcli kdePackages.kwallet-pam kdePackages.drkonqi kwayland-integration plasma-vault kdePackages.print-manager kdePackages.qtwayland

      # qt6-wayland     -- not found on nixos pkgs
      # TODO: other CRITICAL THINGS THAT HAVE NO EQUIVALENT PACKAGES
      # TODO: CHECK IF GPU IS ACTUALLY WORKING!!!
      # linux-surface
      # linux-surface-headers
      # libwacom-surface  -- might need some additional configuration as well here!
    ];
    
    # ???
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:
    services.thermald.enable = true;
    services.auto-cpufreq.enable = true;
    services.printing.enable = true;

    environment.etc."vimrc".text = ''
      " get rid of maddening mouseclick-moves-cursor behavior
      set mouse=
      set ttymouse=
    '';

    # TODO: Setup OpenSSH with keys
    # users.(...).openssh = {}
   
    # npm
    programs.npm.enable = true;

    # Hyprland
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    programs.xwayland.enable = true;
    environment.sessionVariables = rec {
      NIXOS_OZONE_WL = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
    };

    # SDDM
    services.xserver.videoDrivers = [ "nvidia" "modesetting" "vesa" "intel" ];
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.settings.General.LogLevel = "debug";
    services.displayManager.sddm.wayland.enable = true;
    services.xserver.displayManager.sessionCommands = ''
      ${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --components=secrets &
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    '';
    services.xserver.enable = true;
    security.polkit.enable = true;
    security.pam.services.login = {#sddm = {
      kwallet.enable = true;
      enableKwallet = true;
      kwallet.package = pkgs.kdePackages.kwallet-pam;
    };

    # Thunar Xfce File manager
    programs.thunar.enable = true;
    programs.xfconf.enable = true;
    services.gvfs.enable = true;	# Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    #program.thunar.plugins = with pkgs.xfce; [
    #	thunar-archive-plugin
    #	thunar-volman
    #];

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Enable iptsd (Userspace daemon for Intel Precise Touch & Stylus
    services.iptsd.enable = true;

    # Enable iwd (Wireless daemon for Linux)
    networking.wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
      };
    };
    # Enable preload
    services.preload.enable = true;

    # Lets add updateMicrocode since we previously also had intel-ucode installed on arch
    hardware.cpu.intel.updateMicrocode = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?
    

    # WE ADD ABILITY FOR FLAKES
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings = {
      builders-use-substitutes = true;
      # substituters to use
      substituters = [
          "https://anyrun.cachix.org"
          "https://nix-community.cachix.org"
          "https://cache.nixos.org/"
          "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
          "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
  }; 
}
