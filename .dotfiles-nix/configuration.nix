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
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
  systemd.user.services.udiskie = {
    description = "Automount service using udiskie for user devices";
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
    shell = pkgs.zsh;
  };
  nixpkgs.config.allowUnfree = true;

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
    device = lib.mkDefault "/dev/nvme0n1p1";
    fsType = lib.mkDefault "vfat";
  };
  environment.systemPackages = with pkgs; [
      # essential editors,utils
      vim_configurable neovim pciutils lshw kitty wget os-prober gh udiskie udisks2
      # wireless
      wpa_supplicant wpa_supplicant_ro_ssids wpa_supplicant_gui
      # packages for libdbusmenu ???
      libdbusmenu libsForQt5.libdbusmenu libdbusmenu-gtk3 libdbusmenu-gtk2
      # gnome bluetooth (needed for ags ???)
      gnome.gnome-bluetooth gnome.gnome-bluetooth_1_0 gnomeExtensions.bluetooth-battery
      # utils and drivers, nvidia/surface
      libva libwacom-surface surface-control zenith-nvidia

      ### KDE STUFF THAT MIGHT BE USEFUL ###
      # REM30.4 kdePackages.kwallet # Or just the libraries w/o graphical: libsForQt5.kwallet
      # REM30.4 kdePackages.kwalletmanager
      # REM30.4 kwallet-pam
      # REM30.4 kwalletcli
      # REM30.4 kdePackages.kwallet-pam
      # REM30.4 kdePackages.drkonqi # Crash handler for KDE software. Probably not needed.
      # REM30.4 kwayland-integration

      # polkit, keyring, auth
      polkit_gnome
      gnome.gnome-keyring

      # REM30.4 libsForQt5.layer-shell-qt
      # REM30.4 plasma-vault

      # the following two packages needed for sugardark sddm theme to work properly:
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects

      # REM30.4 kdePackages.print-manager
      # qt6-wayland     -- not found on nixos pkgs
      # REM30.4 kdePackages.qtwayland

      # Icon themes:
      gnome-icon-theme
      papirus-icon-theme
      numix-icon-theme
      iconpack-obsidian
      iconpack-jade

      # TODO: other CRITICAL THINGS THAT HAVE NO EQUIVALENT PACKAGES
      # TODO: CHECK IF GPU IS ACTUALLY WORKING!!!
      # linux-surface
      # linux-surface-headers
      # libwacom-surface  -- might need some additional configuration as well here!
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
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
