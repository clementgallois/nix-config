{ pkgs, ... }:
{
  services = {
    desktopManager.gnome = {
      enable = true;
    };
    displayManager.gdm = {
      enable = true;
    };
    # Enable touchpad/mouse support (enabled default in most desktopManager).
    #libinput.enable = true;
  };

  # remove stuff
  services.gnome.gnome-initial-setup.enable = false;
  # https://github.com/NixOS/nixpkgs/blob/456e8a9468b9d46bd8c9524425026c00745bc4d2/nixos/modules/services/desktop-managers/gnome.nix#L455
  services.gnome.core-apps.enable = false;
  # https://github.com/NixOS/nixpkgs/blob/456e8a9468b9d46bd8c9524425026c00745bc4d2/nixos/modules/services/desktop-managers/gnome.nix#L539
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  # pick what i really want
  environment.systemPackages = with pkgs; [
    nautilus # file manager (maybe look at https://github.com/NixOS/nixpkgs/blob/456e8a9468b9d46bd8c9524425026c00745bc4d2/nixos/modules/services/desktop-managers/gnome.nix#L503)
    loupe # photo viewer
    papers # document viewer
    decibels # audio player
    showtime # video player
    simple-scan # scanner
    baobab # view disk usage
    gnome-clocks
    gnome-calculator
    gnome-console
    gnome-weather
    gnome-calendar
    gnome-text-editor
    gnome-maps
    gnome-system-monitor
    snapshot # preview webcam before meeting ?
  ];
  programs.gnome-disks.enable = true;
  programs.seahorse.enable = true; # gui for keyrings ? idk
  services.gnome.sushi.enable = true; # file preview in nautilus

  # gnome-software
  services = {
    flatpak.enable = true;
    gnome.gnome-software.enable = true;
  };
  # Fix broken stuff
  services.avahi.enable = false;
  networking.networkmanager.enable = true;
}
