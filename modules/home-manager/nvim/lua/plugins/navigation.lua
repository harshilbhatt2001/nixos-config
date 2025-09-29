return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Use harpoon v1 API to match original configuration
      require("harpoon").setup()
      
      -- Harpoon keybinds
      vim.keymap.set('n', '<leader>mm', require('harpoon.mark').add_file, "[M]ark file in harpoon")
      vim.keymap.set('n', '<leader>mh', require('harpoon.ui').toggle_quick_menu, "[M]enu [H]arpoon")
    end,
  },
  -- Uncommented undotree as it was available in the original overlay
  -- {
  --   "jiaoshijie/undotree",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   config = function()
  --     require("undotree").setup()
  --   end,
  -- },
}