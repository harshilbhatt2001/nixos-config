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

-- Telescope keybinds
map('n', '<leader><space>', function() require('telescope.builtin').find_files() end, '[ ]Search Files')
map('n', '<leader>sb', function() require('telescope.builtin').buffers() end, '[S]earch [B]uffers')
map('n', '<leader>sh', function() require('telescope.builtin').help_tags() end, '[S]earch [H]elp')
map('n', '<leader>sw', function() require('telescope.builtin').grep_string() end, '[S]earch current [W]ord')
map('n', '<leader>sg', function() require('telescope.builtin').live_grep() end, '[S]earch by [G]rep')
map('n', '<leader>sd', function() require('telescope.builtin').diagnostics() end, '[S]earch [D]iagnostics')

map({ 'n', 't' }, '<A-t>', function() require("FTerm").toggle() end, 'Toggle Terminal')

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })