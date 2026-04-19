# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./vm_tweaks.nix
      ./openssh.nix
      ./sops.nix
      ./zsh.nix
      ./neovim.nix
    ];
    #++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
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
