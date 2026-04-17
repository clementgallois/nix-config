{ pkgs, ...}:
{
  # Starship Prompt
  programs.starship.enable = true;
  
  # Smarter cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
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

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
  };
}
