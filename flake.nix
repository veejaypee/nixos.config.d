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

outputs = { self, nixpkgs, ... }@inputs:
let
system = "x86_64-linux";
pkgs = nixpkgs.legacyPackages.${system};
in {
nixosConfigurations = {
ganesha = nixpkgs.lib.nixosSystem {
specialArgs = { inherit inputs; };
modules = [
./hosts/ganesha/configuration.nix 
./modules/nixvim/config/default.nix
inputs.home-manager.nixosModules.default
];
};
};
};
}
