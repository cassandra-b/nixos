{ lib, pkgs, ... }:

{
  imports = [ ./neovim ];

  home = {
    enableNixpkgsReleaseCheck = true;
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
      # TODO userEmail = "...";
      userName = "Cassie Bleskachek";
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
