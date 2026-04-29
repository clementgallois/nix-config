# more generic ? idk
# using the common one for now
{ pkgs, ... }:
{
  programs.steam = {
    enable = true;

    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };

  environment.systemPackages = [
    pkgs.protontricks
  ];
}
