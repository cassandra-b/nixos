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

      # Fonts
      pkgs.iosevka
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk
      pkgs.noto-fonts-emoji

      # Utilities (CLI)
      pkgs.fd
      pkgs.file
      pkgs.iperf3
      pkgs.ncdu
      pkgs.ripgrep
      pkgs.mono5
      pkgs.python3Full
      pkgs.joycond

      # Utilities (GUI)
      pkgs.arandr
      pkgs.sct
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
