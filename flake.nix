{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
    let
        system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
    in with pkgs; {
        packages.${system} = rec {
	    hello = pkgs.hello;

            default = hello;
        };
	
	nixosConfigurations = {
	   "desktop" = nixpkgs.lib.nixosSystem {
	       modules = [ ./hosts/desktop ];
	       specialArgs = { inherit inputs pkgs; outputs = self; };
	   };
	};
    };
}
