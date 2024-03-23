{
description = "Vjps base flake";

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
};

outputs = { self, nixpkgs, nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = import ./config; # import the module directly
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            # inherit (inputs) foo;
          };
        };
        nvim = nixvim'.makeNixvimWithModule nixvimModule;
      in {
        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        };

let
system = "x86_64-linux";
pkgs = nixpkgs.legacyPackages.${system};
in {
nixosConfigurations = {
ganesha = nixpkgs.lib.nixosSystem {
specialArgs = { inherit inputs; };
modules = [
./hosts/ganesha/configuration.nix 
./modules/nixvim/config
inputs.home-manager.nixosModules.default
];
};
};
};
}
