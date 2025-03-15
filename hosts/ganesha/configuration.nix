# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  inputs,
  config,
  stylix,
  hyprland,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/google-chrome/config
    ../../modules/stylix/config
    ../../modules/hyprland
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # https://nixos.wiki/wiki/OBS_Studio
  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw

  networking.hostName = "ganesha"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
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
  ## Hyprland cachix
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  ## Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ## X11 for XWayland
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };
  hardware.wooting.enable = true;

  ## Login Manager
  services = {
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vjp = {
    isNormalUser = true;
    description = "VJP";
    extraGroups = ["networkmanager" "wheel" "audio" "storage" "gamemode" "input"];
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    sharedModules = [
      ../../modules/stylix/config
    ];
    users.vjp = {
      imports = [
        ./home.nix
      ];
    };
  };

  # nVidia
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  programs.waybar = {
    enable = true;
  };

  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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

  environment.shells = with pkgs; [zsh];
  programs.zsh = {
    enable = true;
    shellAliases = {
      nsr = "nix-shell --run";
    };
  };
  programs.dconf.enable = true;

  environment.variables.EDITOR = "nvim";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## Hyprland
    wofi
    eww
    hyprpaper
    hyprshot
    wlr-randr

    ## Sound
    pavucontrol
    helvum

    ## Hardware - Mouse
    libratbag
    piper

    ## Hardware - Keyboard
    wooting-udev-rules
    wootility

    ## Benchmarking
    phoronix-test-suite
    SDL2
    openal

    # nix os utils
    yazi
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

    node2nix
    nodejs
    typescript
    typescript-language-server
    vscode-extensions.angular.ng-template
    # ruby
    rustup

    # jetbrains.idea-community

    # doom emacs deps
    emacs
    ripgrep
    fd
    editorconfig-core-c

    ## User apps
    obsidian
    # browser
    chromium

    # media / communication
    noisetorch
    spotify
    spotify-player
    signal-desktop

    # flameshot
    grim

    ## gaming
    protonup-qt
    winetricks
    protontricks
    sunshine
    freeciv

    xonotic

    lutris

    vulkan-tools

    # minecraft
    jdk17
    jdk8
    prismlauncher
    cubiomes-viewer

    # stream
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
    transmission_4-qt

    # comic & eReading
    calibre
    yacreader

    neofetch
  ];

  fonts.packages = with pkgs; [
    # nerd-fonts.0xproto
    nerd-fonts._3270
    nerd-fonts.agave
    nerd-fonts.anonymice
    nerd-fonts.arimo
    nerd-fonts.aurulent-sans-mono
    nerd-fonts.bigblue-terminal
    nerd-fonts.bitstream-vera-sans-mono
    nerd-fonts.blex-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
    nerd-fonts.code-new-roman
    nerd-fonts.comic-shanns-mono
    nerd-fonts.commit-mono
    nerd-fonts.cousine
    nerd-fonts.d2coding
    nerd-fonts.daddy-time-mono
    nerd-fonts.departure-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.envy-code-r
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.geist-mono
    nerd-fonts.go-mono
    nerd-fonts.gohufont
    nerd-fonts.hack
    nerd-fonts.hasklug
    nerd-fonts.heavy-data
    nerd-fonts.hurmit
    nerd-fonts.im-writing
    nerd-fonts.inconsolata
    nerd-fonts.inconsolata-go
    nerd-fonts.inconsolata-lgc
    nerd-fonts.intone-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.jetbrains-mono
    nerd-fonts.lekton
    nerd-fonts.liberation
    nerd-fonts.lilex
    nerd-fonts.martian-mono
    nerd-fonts.meslo-lg
    nerd-fonts.monaspace
    nerd-fonts.monofur
    nerd-fonts.monoid
    nerd-fonts.mononoki
    nerd-fonts.mplus
    nerd-fonts.noto
    nerd-fonts.open-dyslexic
    nerd-fonts.overpass
    nerd-fonts.profont
    nerd-fonts.proggy-clean-tt
    nerd-fonts.recursive-mono
    nerd-fonts.roboto-mono
    nerd-fonts.shure-tech-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.space-mono
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    nerd-fonts.tinos
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.victor-mono
    nerd-fonts.zed-mono

    source-code-pro
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
  programs.gamemode.enable = true;

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
