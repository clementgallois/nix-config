{ config, ... }:
{
  # seem like the cooler kid for nix commands
  # nh os switch
  # nh os switch ~/NixConfig#desktop (to specify hostname/dir)
  # nh clean all --keep 3
  # also enable automatic cleaning with clean arg (default weekly)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${config.home.homeDirectory}/NixConfig";
  };
}
