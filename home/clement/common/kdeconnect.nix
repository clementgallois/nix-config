{ pkgs, ... }:
{
  # services = {
  #   kdeconnect = {
  #     enable = true;
  #     indicator = true;
  #   };
  # };

  # for Gnome
  programs.gnome-shell = {
    enable = true;
    extensions = [ { package = pkgs.gnomeExtensions.gsconnect; } ];
  };
}
