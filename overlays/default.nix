{ inputs, ... }:
{
  nvim-plugins = final: prev: {
    undotree-nvim = prev.vimUtils.buildVimPlugin {
      name = "undotree-nvim";
      src = inputs.plugin-undotree-nvim;
    };
  };
}
