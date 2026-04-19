{ pkgs, config, ... }:

{
  # Zsh Configuration
# default: https://github.com/starcraft66/os-config/blob/master/home-manager/programs/zsh.nix
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    autosuggestion.enable = true; 
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      # update = "nh os switch"; # C'est le moment de l'activer !
    };

    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # default
      extended = true;
      share = true; # default (share history between terminal windows)
      size = 100000; # default
      save = 100000; # default
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      directory = {
        truncate_to_repo = false;
      };
    };
  };

  # Zoxide (Smarter cd)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ]; 
  };

  # FZF (Fuzzy finder)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Pay-respects (press f to correct last command)
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
  };
}
