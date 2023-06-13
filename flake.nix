{
  description = "styley's dotfiles managed via nixos and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    ...
  }: let
    createHost = {hostName}:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager impermanence;
          user = "styley";
          host = hostName;
        };

        modules = [
          home-manager.nixosModules.home-manager
          inputs.impermanence.nixosModules.impermanence
          ./hosts
          ./hosts/${hostName} # host specific configuration, including hardware
        ];
      };
  in {
    nixosConfigurations = {
      desktop = createHost {hostName = "desktop";};
      aspire = createHost {hostName = "aspire";};
      g15 = createHost {hostName = "g15";};
      vm = createHost {hostName = "vm";};
    };
  };
}
