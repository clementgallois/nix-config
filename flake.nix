{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
        system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
    in with pkgs; {
        packages.${system} = rec {
	    hello = pkgs.hello;

            default = hello;
        };
	
	nixosConfigurations = {
	   "nixos" = nixpkgs.lib.nixosSystem {
	       modules = [ ./hosts/desktop ];
	       specialArgs = { inherit pkgs; };
	   };
	};
    };
}
