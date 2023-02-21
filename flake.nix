{
  description = "styley's dotfiles managed via nixos and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      createHost = { hostName }: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager;
          user = "styley";
        };

        modules = [
          home-manager.nixosModules.home-manager
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
