{
  description = "NixOS + Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvim.url = "github:yikesboy/nvim";
    battery-warning.url = "github:yikesboy/battery-warning";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nvim,
      battery-warning,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      nixosConfigurations.luna = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit nixpkgs-unstable; };
        modules = [
          ./hosts/luna

          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              (_: prev: {
                unstable = import nixpkgs-unstable {
                  system = prev.stdenv.hostPlatform.system;
                  config.allowUnfree = true;
                };
              })
            ];
          }
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = {
              inherit nixpkgs-unstable nvim battery-warning;
            };
            home-manager.users.lukas = import ./modules/home/home.nix;
          }
        ];
      };
    };
}
