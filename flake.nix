{
  description = "styley's dotfiles managed via nixos and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, lib, ... }:
    let
      createHost = { hostName }: lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
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
      nixosConfigurations =  {
        desktop = createHost { hostName = "desktop"; };
        laptop = createHost {hostName = "laptop"; };
        vm = createHost {hostName = "vm"; };
      };
    };
}
