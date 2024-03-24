{
  description = "Veits base flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-parts,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    nixconf = import ./hosts/ganesha/configuration.nix {inherit inputs;};
  in {
    nixosConfigurations = {
      ganesha = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/ganesha/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
