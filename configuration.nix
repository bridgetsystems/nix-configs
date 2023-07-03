# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia-470.nix
    ];
  
  # Enable non-free packages.
  nixpkgs.config.allowUnfree = true;
  # Experimental Nix features (commands and flakes).
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allows myself to configure binary caches (i.e use `nix run`)
  nix.settings.trusted-users = [ "root" "bridget" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use the ZFS filesystem.
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.luks.devices = {
  root = {
    device = "/dev/sda2";
    preLVM = true;
    };
  };  

  # Enable automatic garbage collection.
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8d";
  };

  # Enable zram.
  zramSwap.enable = true;

  networking.hostName = "shitpad"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostId = "795c2c22";  # Networking hostId for ZFS.

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  }; # locale go brrr

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;  
  # Exclude the Elisa music player from the packages installed alongisde Plasma.
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
   elisa
  ];
  
  # Autologin (kinda sussy).
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "bridget";
 
  # Enables flatpak.
  services.flatpak.enable = true;
 
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable the fish shell 
  programs.fish.enable = true;

  # Defines a user account.
  users.users.bridget = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # sudo
    description = "Bridget Steele";
    shell = pkgs.fish; # i <3 fish nya~
    packages = with pkgs; [
      btop
      kate
      hyfetch
      pkgs.nur.repos.baduhai.klassy #see flake.nix
      keepassxc
      libsForQt5.kdeconnect-kde     
      #schildichat-desktop
      firefox
      (discord.override {withOpenASAR = true; withVencord = true;})
      audacious
      prismlauncher-qt5
      vlc
      git # git 
      gh # ditto but ms
      steam
      kolourpaint
      yt-dlp
      protonup-qt
      adoptopenjdk-openj9-bin-8
      kcharselect
      libsForQt5.kpat
      libsForQt5.kmahjongg
      kmines
      qbittorrent
      krusader
      kdiff3
      krename
      thunderbird
      libreoffice-qt
      partition-manager
      akregator
      zip
      unzip
      rar
      unrar
      p7zip
      birdtray
      whatsapp-for-linux
      nerdfonts
      okteta
      openttd
      openrct2
      katawa-shoujo
      plasma-overdose-kde-theme
      libsForQt5.tokodon
    ];
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = { 
    enable = false;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # ports for KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # ditto
    ];  
  };  

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
