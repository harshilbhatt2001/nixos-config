{ inputs, ... }:
{
  nvim-plugins = final: prev: {
    undotree-nvim = prev.vimUtils.buildVimPlugin {
      name = "undotree-nvim";
      src = inputs.plugin-undotree-nvim;
    };
  };

  custom-pkgs = final: prev: {
    cursor = prev.pkgs.callPackage ../custom_packages/cursor/derivation.nix {};
  };
}
