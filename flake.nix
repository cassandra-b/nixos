{
  inputs = {
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-22.11";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };
  outputs = { self, home-manager, nixpkgs }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [ home-manager.nixosModule (import ./configuration.nix inputs) ];
    };
  };
}
