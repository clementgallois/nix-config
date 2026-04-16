{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
	nixosConfigurations = {
	   "desktop" = nixpkgs.lib.nixosSystem {
	       modules = [ ./hosts/desktop ];
	       specialArgs = { inherit inputs; outputs = self; };
	   };
	};
    };
}
