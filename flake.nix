{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
            inherit system;
	    modules = [ 
              ./hosts/harshil/configuration.nix
            ];
        };
      };

      homeConfigurations = {
        harshil = home-manager.lib.homeManagerConfiguration {
	    inherit pkgs;
            modules = [ 
	      ./home.nix
            ];
        };
      };
    };

}
