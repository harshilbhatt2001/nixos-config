{ inputs, lib, config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # Required external tools
      git # Required for lazy.nvim
      ripgrep # Required for telescope
      wl-clipboard # Required for clipboard sync
      typescript # Required for typescript-tools-nvim

      # Language servers
      clang-tools
      lua-language-server
      kotlin-language-server
      pyright
      #zls
    ];

    # Only include lazy.nvim for plugin management
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig = ''
      -- Set up the Lua configuration path
      vim.opt.runtimepath:prepend("${./lua}")
      
      -- Initialize our Lua configuration
      require("config")
    '';
  };
}
