# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw

  networking.hostName = "ganesha"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Hardware
  sound.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
    # mouse
    libinput = {
      enable = true;
      # no mouse accel
      mouse = {
        accelProfile = "flat";
      };
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
  # nVidia
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackiges.nvidiaPackages.beta;
  };

  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  ## Hyprland
  programs.hyprland = {
    enable = true;
  };
  programs.waybar = {
    enable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vjp = {
    isNormalUser = true;
    description = "VJP";
    extraGroups = ["networkmanager" "wheel" "audio" "storage"];
    packages = with pkgs; [];
  };

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs;};
    users = {
      "vjp" = import ./home.nix;
    };
  };

  environment.shells = with pkgs; [zsh];
  programs.zsh = {
    enable = true;
    shellAliases = {
      nsr = "nix-shell --run";
    };
  };
  programs.dconf.enable = true;

  # Allow unfree packages
  nixpkgs = {
    # You can add overlays here
    overlays = [
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # neovim nvim neo vim
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   viAlias = true;
  #   vimAlias = true;
  # };
  environment.variables.EDITOR = "nvim";

  programs.gamemode.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## Hyprland
    wofi
    eww
    ## Sound
    pavucontrol
    # hardware - mouse
    libratbag
    piper
    # nix os utils
    nixfmt # .nix formatter
    ranger
    unzip

    #Hyperland to XWayland apps clipboard
    wl-clipboard-x11

    # classic sys utils
    git
    wget
    bash
    fzf
    tree
    jq

    ## Langs
    gcc # C
    # python3
    nodejs
    ruby
    rustup
    ## Dev
    alacritty
    tmux
    # doom emacs deps
    emacs
    ripgrep
    fd
    editorconfig-core-c
    ## User apps
    # browser
    firefox
    tridactyl-native
    chromium
    # media / communication
    noisetorch
    spotify
    signal-desktop

    # flameshot
    grim
    ## gaming
    protonup-qt
    sunshine
    # minecraft
    openjdk17
    prismlauncher
    # stream
    obs-studio
    transmission_4-qt
    # mcomix
    yacreader
  ];

  fonts.packages = with pkgs; [
    source-code-pro
    fira-code
    nerdfonts
    meslo-lgs-nf
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # services.flatpak.enable = true;

  ## gaming

  # steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
