{ nixpkgs, ... }:

{ config, lib, modulesPath, pkgs, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    cleanTmpDir = true;
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "boot.shell_on_fail" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
      };
      systemd-boot.enable = false;
    };
  };

  fileSystems = {
    "/" = {
      device = "nvme/root";
      fsType = "zfs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/1a2a3664-fc33-4f77-947a-83155cb06c6b";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/D0A2-DAD4";
      fsType = "vfat";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    steam-hardware.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.cassie = import ./home.nix;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    firewall.enable = false;
    hostId = "57dcc04c";
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix = {
    nixPath = [ "nixpkgs=${nixpkgs}" ];
    registry.nixpkgs.flake = nixpkgs;
    extraOptions = ''
      # Enable Flakes and nix(1)
      experimental-features = flakes nix-command

      # Prevent direnv/nix-shell/nix develop environments from getting GC'd.
      keep-derivations = true
      keep-outputs = true
    '';
  };

  nixpkgs = {
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "discord"
        "google-chrome"
        "steam"
        "steam-original"
        "steam-run"
        "sublimetext4"
        "zoom"
        "nvidia-x11"
        "nvidia-settings"
        "fcitx5"
        "minecraft-launcher"
      ];
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  programs = {
    # Enabled by default by Cinnamon.
    gnome-terminal.enable = false;
    zsh.enable = true;
    steam.enable = true;
  };

  services = {
    cinnamon.apps.enable = true;
    joycond.enable = true;
    xserver = {
      videoDrivers = [ "nvidia" "modesetting" ];
      enable = true;
      desktopManager.cinnamon.enable = true;
      libinput.enable = true;
    };
    zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
    };
  };

  # This is the version of NixOS that was *originally* installed. Do not change
  # this when updating!
  system.stateVersion = "22.11";

  time.timeZone = "America/Chicago";

  users.users.cassie = {
    description = "Cassie Bleskachek";
    extraGroups = [ "video" "wheel" ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
