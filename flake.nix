{
  description = "styley's dotfiles managed via nixos and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, impermanence, ... }:
    let
      createHost = { hostName }: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager impermanence;
          user = "styley";
        };

        modules = [
          home-manager.nixosModules.home-manager
          inputs.impermanence.nixosModules.impermanence
          ./hosts
          ./hosts/${hostName} # host specific configuration, including hardware
        ];
      };
    in
    {
      nixosConfigurations = {
        desktop = createHost { hostName = "desktop"; };
        laptop = createHost { hostName = "laptop"; };
        vm = createHost { hostName = "vm"; };
      };
    };
}
