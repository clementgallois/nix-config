{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.clement = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ifTheyExist [
      "audio"
      "git"
      "libvirtd"
      "wpa_supplicant"
      "podman"
      "wheel"
    ];

    #openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/gabriel/ssh.pub);
    hashedPasswordFile = config.sops.secrets.clement_password.path;
    #packages = [pkgs.home-manager];
  };

  sops.secrets.clement_password = {
    sopsFile = ./secrets.yaml;
    neededForUsers = true;
  };

  virtualisation.vmVariant = {
    users.users.clement.hashedPasswordFile = lib.mkForce null;
    users.users.clement.password = "nixos";
    sops.secrets.clement_password.neededForUsers = lib.mkForce false;
  };
  #home-manager.users.gabriel = import ../../../../home/gabriel/${config.networking.hostName}.nix;

  #security.pam.services = {
    #swaylock = {};
    #hyprlock = {};
  #};
}
