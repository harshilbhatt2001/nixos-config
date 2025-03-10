{ inputs, lib, config, pkgs, ... }:
{

  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        #nodejs_21 # Required for copilot-vim
        ripgrep # Required for telescope
        wl-clipboard # Required for clipboard sync
        typescript # Required for typescript-tools-nvim

        # Language servers
        clang-tools
        lua-language-server
        kotlin-language-server
        pyright
      ];


      plugins = with pkgs.vimPlugins; [
        {
          plugin = telescope-nvim;
          config = toLuaFile ./plugins/telescope.lua;
        }
        telescope-ui-select-nvim
        {
          plugin = neogit;
          config = toLua ''
            require('neogit').setup {}
          '';
        }
        neodev-nvim
        plenary-nvim
        diffview-nvim
        nvim-treesitter-parsers.devicetree
        nvim-treesitter-parsers.kconfig

        {
          plugin = vim-fugitive;
          config = toLuaFile ./plugins/fugitive.lua;
        }

        {
          plugin = todo-comments-nvim;
          config = toLua '' require('todo-comments').setup() '';
        }

        FTerm-nvim

        vim-python-pep8-indent
        cmp-nvim-lsp
        cmp-nvim-lsp-signature-help
        cmp-buffer
        cmp-path
        cmp-git
        cmp-calc
        cmp-cmdline
        cmp_luasnip
        copilot-cmp
        luasnip
        friendly-snippets
        {
          plugin = nvim-cmp;
          config = toLuaFile ./plugins/cmp.lua;
        }

        {
          plugin = gruvbox-nvim;
          config = toLuaFile ./plugins/gruvbox.lua;
        }

        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./plugins/lsp.lua;
        }
        rust-tools-nvim
        typescript-tools-nvim

        rainbow-delimiters-nvim

        #{
        #  plugin = undotree-nvim;
        #  config = toLua "require('undotree').setup()";
        #}

        harpoon

        {
          plugin = copilot-lua;
          config = toLua ''
            require("copilot").setup({
              suggestion = { enabled = false },
              panel = { enabled = false },
            })
          '';
        }

      ];

      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
        ${builtins.readFile ./remap.lua}
      '';
    };
}
