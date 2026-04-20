{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./nh.nix
    ./neovim
  ];

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  # enable xdg directory handling (~/.config)
  xdg.enable = true;

  home = {
    username = lib.mkDefault "clement";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "25.11";
    
    sessionPath = ["$HOME/.local/bin"];

    # defined in nh.nix
    # sessionVariables = {
    #   NH_FLAKE = "$HOME/NixConfig";
    # };

    packages = with pkgs; [
      cowsay
    ];
    # persistence = {
    #   "/persist".directories = [
    #     "Documents"
    #     "Downloads"
    #     "Pictures"
    #     "Videos"
    #     ".local/bin"
    #     ".local/share/nix" # trusted settings and repl history
    #   ];
    # };
  };

  # colorscheme.mode = lib.mkOverride 1499 "dark";
  # specialisation = {
  #   dark.configuration.colorscheme.mode = lib.mkOverride 1498 "dark";
  #   light.configuration.colorscheme.mode = lib.mkOverride 1498 "light";
  # };
  # home.file = {
  #   ".colorscheme.json".text = builtins.toJSON config.colorscheme;
  # };
}
