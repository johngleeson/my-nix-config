let
  myTimeZone = "Europe/Dublin";
  myLocale = "en_IE.UTF-8";
  mySubstituters = ["https://cache.nixos.org/" "https://nix-community.cachix.org/"];
  myTrustedKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
in
  {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [./hardware-configuration.nix];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.supportedFilesystems = ["ntfs"];
    /*
       boot.kernelParams = [
      "pci=noacpi" # Disable ACPI for all PCI devices
      "pcie_aspm=off" # Disable Active State Power Management for PCIe links
      "pci=disable=8086:9a49" # Disable the integrated GPU (GT2)
    ];
    */
    boot.loader.systemd-boot.configurationLimit = 5;
    boot.loader.grub.default = 0;

    # Setup keyfile
    boot.initrd.secrets = {"/crypto_keyfile.bin" = null;};

    # Enable swap on luks
    boot.initrd.luks.devices."luks-4361bdeb-a8d7-445f-b41c-20314f98d6ea".device = "/dev/disk/by-uuid/4361bdeb-a8d7-445f-b41c-20314f98d6ea";
    boot.initrd.luks.devices."luks-4361bdeb-a8d7-445f-b41c-20314f98d6ea".keyFile = "/crypto_keyfile.bin";

    nix = {
      gc = {
        automatic = true;
        options = "--delete-generations +10";
      };

      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      settings = {
        substituters = mySubstituters;
        trusted-public-keys = myTrustedKeys;
      };
    };

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    hardware.keyboard.qmk.enable = true;
    time.timeZone = myTimeZone;

    i18n.defaultLocale = myLocale;
    i18n.extraLocaleSettings = {
      LC_ADDRESS = myLocale;
      LC_IDENTIFICATION = myLocale;
      LC_MEASUREMENT = myLocale;
      LC_MONETARY = myLocale;
      LC_NAME = myLocale;
      LC_NUMERIC = myLocale;
      LC_PAPER = myLocale;
      LC_TELEPHONE = myLocale;
      LC_TIME = myLocale;
    };

    # X11 Server Configuration
    #services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

    services.printing.enable = true;
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.apparmor.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.tailscale.enable = true;
    #services.xserver.videoDrivers = [ "modesetting" ];
    services.xserver.videoDrivers = ["intel"];
    services.udev.packages = [pkgs.yubikey-personalization pkgs.udev];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
    };

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
    programs.zsh.enable = true;
    programs.gnupg.agent.pinentryPackage = pkgs.pinentry-qt;
    programs.kdeconnect.enable = true;
    users.users.john = {
      isNormalUser = true;
      description = "John";
      extraGroups = ["networkmanager" "wheel" "docker"];
      shell = pkgs.zsh;
      packages = with pkgs; [
        android-tools
        anytype
        appflowy
        bruno
        dolphin-emu
        pcsx2
        rpcs3
        warp-terminal
        #retroarchFull
        #cemu
        #floorp-unwrapped
      ];
    };

    fonts.packages = with pkgs; [(nerdfonts.override {fonts = ["SourceCodePro" "DroidSansMono"];})];
    environment.shells = with pkgs; [zsh];
    /*
    environment.variables = {
       NIX_PATH = "nixpkgs=${nixpkgsPath}";
    };
    */
    nixpkgs.config.allowUnfree = true;

    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };

    nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiVdpau
        libvdpau-va-gl
        intel-compute-runtime
        mesa
        vulkan-loader
      ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      alejandra
      ansible
      ansible-lint
      bitwarden-cli
      btop
      ddccontrol
      ddccontrol-db
      distrobox
      dust
      eza
      fzf
      ffmpeg
      git
      gimp
      gparted
      guestfs-tools
      htop
      i2c-tools
      intel-gpu-tools
      jq
      kitty
      kate
      neovim
      ncdu
      nethogs
      neofetch
      nmap
      obs-studio
      obsidian
      pciutils
      powertop
      protonup-qt
      qemu
      qemu-utils
      quickemu
      rsync
      shadow
      smartmontools
      stacer
      steam-rom-manager
      tldr
      usbutils
      vlc
      wget
      xorg.xkbutils
      yt-dlp
      #yuzu
      qbittorrent
    ];

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
    system.stateVersion = "23.05"; # Did you read the comment?

    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    environment.sessionVariables = {
      DRI_PRIME = "1";
    };

    services.xserver = {
      enable = true;
      deviceSection = ''
        Option "DRI" "3"
      '';
      xkb = {
        layout = "ie"; # Default layout for the internal keyboard
        options = "grp:alt_shift_toggle"; # Switch layouts with Alt+Shift
      };
      config = ''
        Section "InputClass"
                Identifier "Internal Keyboard"
                MatchIsKeyboard "on"
                # Add any specific matching criteria for your internal keyboard if needed
                Driver "evdev"
                Option "XkbLayout" "ie"
                Option "XkbVariant" "basic"
        EndSection

        Section "InputClass"
                Identifier "External Keyboard"
                MatchIsKeyboard "on"
                # Replace "YourVendorName" and "YourProductName" with the actual names
                MatchVendor "04d9"
                MatchProduct "0169"
                Driver "evdev"
                Option "XkbLayout" "us"
                Option "XkbVariant" "basic"
        EndSection
      '';
    };
  }
