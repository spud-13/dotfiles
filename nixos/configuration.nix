# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-00"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  #i18n.defaultLocale = "en_US.UTF-8";
  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #  useXkbConfig = true; # use xkbOptions in tty.
  #};

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager= {
    defaultSession = "none+bspwm";
    lightdm = {
      enable = true;
      greeter.enable = true;
    };
  };

  # Configure keymap in X11
  services.xserver.layout = "us";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false; 
  nixpkgs.config.pulseaudio = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
   };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spud = {
    isNormalUser = true;
    initialPassword = "pw123";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };


  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts-emoji
    noto-fonts-cjk
    dejavu_fonts
    liberation_ttf
    source-code-pro
    terminus_font
  ];


  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #Console Utilities
    vim 
    wget
    neovim
    git
    htop
    unzip
    
    #Console Applications
    ncspot
    neofetch

    #Desktop Applications
    firefox
    xorg.xcalc
    discord
    rxvt-unicode
    mpv
    wine

    #Desktop Environment
    sxhkd
    dmenu
    pywal
    xcompmgr
    lemonbar

  ];

  fileSystems."/media/tm-1" = {
    device = "/dev/disk/by-uuid/38140c19-e579-448b-be9c-484a2aaab11e";
    fsType = "ext4";
  };

  fileSystems."/media/tm-2" = {
    device = "/dev/disk/by-uuid/a94b388a-9ab4-4c08-830b-68bc95b34d7f";
    fsType = "ext4";
  };
 
  fileSystems."/media/tm-3" = {
    device = "/dev/disk/by-uuid/f32e4aa5-a503-48d5-bd7a-4df67d2ebd3b";
    fsType = "ext4";
  };

  fileSystems."/media/tm-4" = {
    device = "/dev/disk/by-uuid/f45eb91c-12f8-45ca-8be7-05ebce2cc5ed";
    fsType = "ext4";
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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

