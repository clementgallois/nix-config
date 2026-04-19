{
  services = {
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
      };
      # Enable touchpad/mouse support (enabled default in most desktopManager).
    libinput.enable = true;
  };
  # Fix broken stuff
  services.avahi.enable = false;
  networking.networkmanager.enable = true;
}
