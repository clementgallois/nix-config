{ pkgs, ...}:
{
  # Starship Prompt
  programs.starship= {
    enable = true;
    settings = {
      directory = {
        # prevent truncation to repo root
        truncate_to_repo = false;
      };
    };
  };

  # Smarter cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    # replace cd
    flags = [ "--cmd cd" ];
  };

  # Fuzzy finder
  # Ensure the package is installed system-wide
  environment.systemPackages = with pkgs; [
    fzf
  ];

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  # Pay-respect
  # press "f" to correct last command
  programs.pay-respects ={
    enable = true;
    # if i want this someday
    #aiIntegration =

    # this is the default but might as well be explicit
    alias = "f";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      #update = "sudo nixos-rebuild switch --flake";
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
  };
}
