{
  description = "papoi";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    pyroclear.url = "github:shreyanth-sureshkrishnaa/pyroclear";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, pyroclear, ... }@inputs: {
    nixosConfigurations.salsa-y-picante = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        {
          environment.systemPackages = [ pyroclear.packages.${system}.default ];
        }
      ];
    };
  };
}
