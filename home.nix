{ lib, pkgs, ... }:

{
  imports = [ ./neovim ];

  fonts.fontconfig.enable = true;

  home = {
    enableNixpkgsReleaseCheck = true;

    packages = [
      pkgs.discord
      pkgs.google-chrome
      pkgs.pavucontrol
      pkgs.signal-desktop
      pkgs.sublime4
      pkgs.zoom-us
      pkgs.vlc
      pkgs.openmw
      pkgs.pocket-casts

      # Fonts
      pkgs.iosevka
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk
      pkgs.noto-fonts-emoji
      pkgs.fcitx5
      pkgs.fcitx5-chinese-addons

      # Utilities (CLI)
      pkgs.fd
      pkgs.file
      pkgs.iperf3
      pkgs.ncdu
      pkgs.ripgrep
      pkgs.mono5
      pkgs.python3Full
      pkgs.linuxKernel.packages.linux_6_2.hid-nintendo
      pkgs.libevdev
      pkgs.joycond
      pkgs.qdirstat
      pkgs.dislocker

      # Utilities (GUI)
      pkgs.arandr
      pkgs.sct
      pkgs.cool-retro-term
    ];

    # This is the version that was *originally* installed. Do not change this
    # when updating!
    stateVersion = "22.11";
  };

  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
      delta = {
        enable = true;
        options.color-only = true;
      };
      userEmail = "cassie.bleskachek@gmail.com";
      userName = "Cassie Bleskachek";
    };
    kitty = {
      enable = true;
      font = {
        name = "Iosevka";
        size = 14;
      };
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "ys";
      };
      plugins = [{
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }];
    };
  };
}
