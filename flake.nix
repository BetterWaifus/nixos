{
  description = "dotfiles managed via nixos and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, agenix, ... }:
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
      nixosConfigurations = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        agenix.nixosModules.default
      ];
        desktop = createHost { hostName = "desktop"; };
        laptop = createHost { hostName = "laptop"; };
        vm = createHost { hostName = "vm"; };
      };
    };
}
