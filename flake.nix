{
  description = "A very basic flake";

  nixConfig = {
    extra-trusted-substituters = [ "https://cache.soopy.moe" ];
    extra-substituters = [
      # substituter for macbook t2
      "https://cache.soopy.moe"
    ];
    extra-trusted-public-keys = [ "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # compilation of hardware conf
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # private repo containing firmwares needed for macbook t2
    brcm-firmware = {
      url = "git+ssh://git@github.com/clementgallois/brcm-firmware.git?ref=main";
      flake = false;
    };
    t2fanrd.url = "github:GnomedDev/T2FanRD";
    # secrets for nix
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Firefox Addons, packaged with nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      #home-manager,
      brcm-firmware,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        "desktop" = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/desktop ];
          specialArgs = {
            inherit inputs;
            outputs = self;
          };
        };
        "macbook-t2" = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/macbook-t2 ];
          specialArgs = {
            inherit inputs;
            outputs = self;
          };
        };
        macbook-iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # 1. Standard NixOS module for creating a bootable minimal ISO
            # (Change to installation-cd-graphical-calamares-plasma6.nix for a GUI)
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"

            # 2. Add your hardware specifics (e.g., T2 linux modules)
            inputs.nixos-hardware.nixosModules.apple-t2

            # 3. Inject private firmwares
            (
              { pkgs, ... }:
              {
                hardware.firmware = [
                  (pkgs.stdenvNoCC.mkDerivation {
                    name = "brcm-firmware";
                    src = brcm-firmware;
                    # Tell Nix to ignore dangling symlinks pointing to the missing cypress folder
                    dontCheckForBrokenSymlinks = true;
                    installPhase = ''
                      mkdir -p $out/lib/firmware
                      cp -r lib/firmware/brcm $out/lib/firmware/

                      # Find and delete all broken symlinks so the zstd compression step does not crash
                      find $out/lib/firmware -xtype l -delete
                    '';
                  })
                ];
              }
            )
          ];
        };
      };
    };
}
