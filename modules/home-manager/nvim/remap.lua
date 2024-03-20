---@diagnostic disable: redefined-local

local function map(mode, keys, func, desc, silent)
    local silent = silent == nil and true or silent
    vim.keymap.set(mode, keys, func, { desc = desc, silent = silent })
end

-- Movement between windows
map('n', '<leader>h', function() vim.cmd.wincmd('h') end, "Window Left")
map('n', '<leader>j', function() vim.cmd.wincmd('j') end, "Window Down")
map('n', '<leader>k', function() vim.cmd.wincmd('k') end, "Window Up")
map('n', '<leader>l', function() vim.cmd.wincmd('l') end, "Window Right")

-- Harpoon keybinds
map('n', '<leader>mm', require('harpoon.mark').add_file, "[M]ark file in harpoon")
map('n', '<leader>mh', require('harpoon.ui').toggle_quick_menu, "[M]enu [H]arpoon")
map('n', '<leader>1', function() require('harpoon.ui').nav_file(1) end, "Harpoon [1]")
map('n', '<leader>2', function() require('harpoon.ui').nav_file(2) end, "Harpoon [2]")
map('n', '<leader>3', function() require('harpoon.ui').nav_file(3) end, "Harpoon [3]")
map('n', '<leader>4', function() require('harpoon.ui').nav_file(4) end, "Harpoon [4]")
map('n', '<leader>5', function() require('harpoon.ui').nav_file(5) end, "Harpoon [5]")
map('n', '<leader>6', function() require('harpoon.ui').nav_file(6) end, "Harpoon [6]")
map('n', '<leader>7', function() require('harpoon.ui').nav_file(7) end, "Harpoon [7]")
map('n', '<leader>8', function() require('harpoon.ui').nav_file(8) end, "Harpoon [8]")
map('n', '<leader>9', function() require('harpoon.ui').nav_file(9) end, "Harpoon [9]")

map('n', '<leader>tg', vim.cmd.Neogit, '[T]oggle [G]it view')
-- map('n', '<leader>tu', require('undotree').toggle, '[T]oggle [U]ndo tree')

map('n', '[d', vim.diagnostic.goto_prev, 'Goto Previous Diagnostic')
map('n', ']d', vim.diagnostic.goto_next, 'Goto Next Diagnostic')
map('n', '<leader>e', vim.diagnostic.open_float, 'Show [E]rrors')
map('n', '<leader>q', vim.diagnostic.setloclist, 'Errors to [Q]uickfix')


map('n', '<leader>?', require('telescope.builtin').oldfiles, '[?] Find recently opened files')
map('n', '<leader><space>', require('telescope.builtin').find_files, '[ ]Search Files')
map('n', '<leader>sb', require('telescope.builtin').buffers, '[S]earch [B]uffers')
map('n', '<leader>sh', require('telescope.builtin').help_tags, '[S]earch [H]elp')
map('n', '<leader>sw', require('telescope.builtin').grep_string, '[S]earch current [W]ord')
map('n', '<leader>sg', require('telescope.builtin').live_grep, '[S]earch by [G]rep')
map('n', '<leader>sd', require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics')

map({ 'n', 't' }, '<A-t>', require("FTerm").toggle, 'Toggle Terminal')

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
