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
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/google-chrome/config
    ../../modules/stylix/config
    ../../modules/hyprland
    ../../modules/fonts
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-6b6a78fe-f573-4b07-a1ec-3f3b886f46bc".device = "/dev/disk/by-uuid/6b6a78fe-f573-4b07-a1ec-3f3b886f46bc";
  networking.hostName = "yorishiro"; # Define your hostname.

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # BH VPN extra hosts
  # BH BE extra hosts
  networking.extraHosts = ''
    127.0.0.1 port-bhyp-b12.bhyp.de
    127.0.0.1 port-bhyp-b02.bhyp.de
    127.0.0.1 port-bhyp-b03.bhyp.de
    127.0.0.1 key-bhyp-b03.bhyp.de
    127.0.0.1 key-bhyp-b02.bhyp.de
    127.0.0.1 byperpcs1q.bhyp.de
    127.0.0.1 byperpcs1d.bhyp.de
    127.0.0.1 sz-bhyp-e05.bhyp.de
    127.0.0.1 sz-bhyp-q05.bhyp.de
    127.0.0.1 ldap-bhyp-b1.bhyp.de
    127.0.0.1 kbv-bhyp-b02.bhyp.de
    127.0.0.1 kpo-bhyp-b02.bhyp.de
    127.0.0.1 atl-bhyp-b01.bhyp.de
    127.0.0.1 repo-bhyp-b01.bhyp.de
    127.0.0.1 harbor.bhyp.de
    127.0.0.1 rancher.bhyp.de
    127.0.0.1 dp-test-current.bhyp.de
    127.0.0.1 dp-test-next.bhyp.de
    127.0.0.1 dp-dev.bhyp.de
    127.0.0.1 k8st-traefik.bhyp.de
    127.0.0.1 k8sb-bhyp-b01.bhyp.de
    172.16.239.10 postgres.x.sclable.io
    172.16.239.11 keycloak.x.sclable.io
    172.16.239.12 wildfly.x.sclable.io
    172.16.239.13 gateway.x.sclable.io
    172.16.239.15 zookeeper.x.sclable.io
    172.16.239.16 kafka.x.sclable.io
    172.16.239.17 schemaregistry.x.sclable.io
    172.16.239.19 control-center.x.sclable.io
    172.16.239.21 oracle.x.sclable.io
    172.16.239.22 prometheus.x.sclable.io
    172.16.239.23 grafana.x.sclable.io
    172.16.239.24 alloy.x.sclable.io
  '';

  programs.ssh.extraConfig = ''
     Host port-bhyp-b12.bhyp.de
    Port 2201

     Host port-bhyp-b02.bhyp.de
    Port 2202

     Host port-bhyp-b03.bhyp.de
    Port 2203
  '';

  # bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth
  services.blueman.enable = true;

  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = with pkgs; [
      tridactyl-native
    ];
  };

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

  # Configure keymap in X11 keeping for XWayland
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Wayland ENVs for chromium based apps
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  ## Fingerprint
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = true;

  ## Sound
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.veitp = {
    isNormalUser = true;
    description = "Veit Poigner";
    extraGroups = ["networkmanager" "wheel" "audio" "storage" "input" "docker"];
    packages = with pkgs; [];
  };

  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  virtualisation.docker = {
    enable = true;
    # Customize Docker daemon settings using the daemon.settings option
    daemon.settings = {
      log-driver = "journald";
      registry-mirrors = ["https://mirror.gcr.io"];
      storage-driver = "overlay2";
    };
    # Use the rootless mode - run Docker daemon as non-root user
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    wofi
    networkmanagerapplet
    docker-compose
    mako

    yazi
    ## Sound Patchbay
    helvum
    pavucontrol

    # sys utils
    unzip

    ripgrep
    fzf #fuzzySearchFinder
    fd
    neofetch

    glib # gsettings

    spotify

    ## Langs
    gcc
    #python3
    nodePackages_latest.nodejs
    nodenv

    ##Language Server - LS
    angular-language-server
    nodePackages_latest.jsonlint
    vscode-langservers-extracted

    node2nix

    ## Apps
    vscode

    # media / comms
    mattermost-desktop

    # tools
    wl-clipboard

    ## BH
    # omnissa-horizon-client
    sqlcl

    ## Playwright
    # firefox-bin
    # patchelf

    insomnia
    # does not work on 23.11
    # postman

    ## sclable.com
    hugo
  ];

  ## Login Manager
  services = {
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
    };
  };
  # stylix.image = ./wallpaper.png;

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    sharedModules = [
      ../../modules/stylix/config
    ];
    users.veitp = {
      imports = [
        ./home.nix
      ];
    };
  };
  environment.variables.EDITOR = "nvim";

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
