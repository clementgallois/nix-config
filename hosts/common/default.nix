# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./vm_tweaks.nix
    ./openssh.nix
    ./sops.nix
    ./zsh.nix
    ./locale.nix
    ./audio-pipewire.nix
    ./gnome.nix
    ./keymap.nix
    ./kdeconnect.nix
    ./steam.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.fira-code

      noto-fonts-color-emoji
    ];
  };

  nixpkgs = {
    #overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  #hardware.enableRedistributableFirmware = true;
  #networking.domain = "m7.rs";

  # Increase open file limit for sudoers
  #security.pam.loginLimits = [
  #{
  #domain = "@wheel";
  #item = "nofile";
  #type = "soft";
  #value = "524288";
  #}
  #{
  #domain = "@wheel";
  #item = "nofile";
  #type = "hard";
  #value = "1048576";
  #}
  #];

  # Cleanup stuff included by default
  #services.speechd.enable = false;
}
