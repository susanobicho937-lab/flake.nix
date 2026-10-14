{
  description = "son😭😭😭";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    pyroclear.url = "github:shreyanth-sureshkrishnaa/pyroclear";
    snowflake-bounce.url = "github:saylesss88/snowflake-bounce";
    antigravity-cli.url = "github:xsen/antigravity-cli-nix";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    serpantinum.url = "github:ilyamiro/serpantinum";
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
     url = "github:nix-community/home-manager";          # master = unstable
     inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, pyroclear, snowflake-bounce, antigravity-cli, serpantinum, caelestia-cli , home-manager , minegrub-world-sel-theme , ... }@inputs: {
    nixosConfigurations.sausy-system = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        minegrub-world-sel-theme.nixosModules.default 
        inputs.serpantinum.nixosModules.default
       home-manager.nixosModules.home-manager
         {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.wasabi = import ./home.nix;
         }
        {
          environment.systemPackages = [
             pyroclear.packages.${system}.default
             snowflake-bounce.packages.${system}.default
             antigravity-cli.packages.${system}.default
             serpantinum.packages.${system}.default
             caelestia-cli.packages.${system}.with-shell
         ];
        }
      ];
    };
  };
}
