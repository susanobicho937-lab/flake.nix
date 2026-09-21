{
  description = "papoi";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.salsa-y-picante = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./hardware-configuration.nix ./configuration.nix ];
    };
  };
}
