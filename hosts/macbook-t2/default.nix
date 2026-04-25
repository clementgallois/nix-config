# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.apple-t2
    inputs.t2fanrd.nixosModules.t2fanrd
    ./t2-fan.nix
    ./t2-suspend-fix.nix
    ./t2-network-notification-fix.nix
    ./t2-touchbar.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./substituter.nix

    ../common
    ../common/users/clement

    ../common/optional/podman.nix

    # wifi network conf
    ../common/optional/network
  ];

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "brcm-firmware-t2";

      src = inputs.brcm-firmware;
      # Tell Nix to ignore dangling symlinks pointing to the missing cypress folder
      dontCheckForBrokenSymlinks = true;

      installPhase = ''
        mkdir -p $out/lib/firmware
        # copy firmwares 
        cp -r lib/firmware/* $out/lib/firmware/

        # Find and delete all broken symlinks so the zstd compression step does not crash
        find $out/lib/firmware -xtype l -delete
      '';
    })
  ];

  boot = {
    loader = {
      systemd-boot = {
        # Bootloader.
        enable = true;
      };
      efi = {
        #canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  networking.hostName = "macbook-t2"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  # networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support
  # in gnome.nix
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
