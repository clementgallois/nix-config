{ pkgs, ... }:
{
  # Enable SANE support for scanners
  hardware.sane.enable = true;

  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
