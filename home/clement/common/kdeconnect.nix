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

  dconf.settings = {
    "org/gnome/shell" = {
      # Allows outdated extensions to load
      disable-extension-version-validation = true;
    };
  };
}
