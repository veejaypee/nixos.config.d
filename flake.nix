{
  description = "veejaypees base flake";

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

    browser-previews = {
      url = "github:nix-community/browser-previews";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    flake-parts,
    browser-previews,
    stylix,
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
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
        ];
      };
    };
    homeConfigurations.vjp = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home.nix
      ];
    };
  };
}
