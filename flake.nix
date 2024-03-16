{

description = "Vjps base flake";

inputs = {
nixpkgs.url = "nixpkgs/nixos-23.11";
};

outputs = { self, nixpkgs, ... }:
let
  lib = nixpkgs.lib;
in {
nixosConfigurations = {
ganesha = lib.nixosSystem {
system = "x86_64-linux";
modules = [ ./configuration.nix ];
};
};
};
}
