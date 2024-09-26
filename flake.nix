{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-undotree-nvim = {
      url = "github:jiaoshijie/undotree";
      flake = false;
    };

    #hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #hyprland.url = "git+https://github.com/andresilva/Hyprland?ref=nix-build-improvements&submodules=1";
    hyprland-plugins = {
        url = "github:hyprwm/hyprland-plugins";
        inputs.hyprland.follows = "hyprland";
    };
    hyprland-hyprspace = {
        url = "github:KZDKM/hyprspace";
        inputs.hyprland.follows = "hyprland";
    };

    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    stylix.url = "github:danth/stylix/release-24.05";

    zen-browser.url = "github:harshilbhatt2001/zen-browser-flake"; # Replace once zen's added to nixpkgs
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (self) outputs;
    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system; 
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/harshil/configuration.nix
            stylix.nixosModules.stylix
          ];
        };
      };

      homeConfigurations = {
        harshil = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home.nix
          ];
        };
      };
    };

}
