local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Source entire config
keymap("n", "<leader><CR>", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = true })

-- Reset
keymap("n", "<Up>", "<Nop>", opts)
keymap("n", "<Down>", "<Nop>", opts)
keymap("n", "<Left>", "<Nop>", opts)
keymap("n", "<Right>", "<Nop>", opts)
keymap("i", "<Up>", "<Nop>", opts)
keymap("i", "<Down>", "<Nop>", opts)
keymap("i", "<Left>", "<Nop>", opts)
keymap("i", "<Right>", "<Nop>", opts)

-- Use Command + S (<D-s>) to save. Requires <D-s> to
-- fire <C-z> inside the terminal as an intermediate command.
-- https://stackoverflow.com/a/63458243
keymap("n", "<C-z>", "<cmd>w<CR>", opts)
keymap("i", "<C-z>", "<ESC><cmd>w<CR>a", opts)

-- Scroll motions
keymap("n", "<leader>f", "<PageDown>", opts)
keymap("n", "<leader>b", "<PageUp>", opts)
keymap("n", "<leader>d", "<C-d>", opts)
keymap("n", "<leader>u", "<C-u>", opts)

-- Select all
keymap("n", "<leader>a", "gg<S-v>G", opts)

-- Escape
keymap("i", "jk", "<Esc>", opts)
keymap("n", "<leader>n", "<cmd>nohlsearch<cr>", opts)

-- Navigate between tabs
-- keymap("n", "<Tab>", ">>", opts)
-- keymap("n", "<S-Tab>", "<<", opts)

-- Why is it backward
keymap("n", "<Tab>", ">>", opts)
keymap("n", "<S-Tab>", "<<", opts)

-- Also this is cool… I think?
keymap("v", "<Tab>", ">gv", opts)
keymap("v", "<S-Tab>", "<gv", opts)

-- Splits
keymap("n", "ss", "<cmd>split<CR>", opts)
keymap("n", "vs", "<cmd>vsplit<CR>", opts)

-- Navigate between windows
keymap("n", "sh", "<C-w>h", opts)
keymap("n", "sj", "<C-w>j", opts)
keymap("n", "sk", "<C-w>k", opts)
keymap("n", "sl", "<C-w>l", opts)

-- Resize windows
keymap("n", "<Up>", "<cmd>resize +4<CR>", opts)
keymap("n", "<Down>", "<cmd>resize -2<CR>", opts)
keymap("n", "<Left>", "<cmd>vertical resize -4<CR>", opts)
keymap("n", "<Right>", "<cmd>vertical resize +4<CR>", opts)

-- Who needs H, M and L
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- Open new tab
keymap("n", "te", "<cmd>tabedit<CR>", opts)

-- since <Tab> === <C-i> we need to find a new solution
-- for the jump list. And also, put them in the right order
-- while we're at it.
keymap("n", "<leader>o", "<C-i>", opts)
keymap("n", "<leader>i", "<C-o>", opts)

-- Navigate in quickfix lists
keymap("n", "<C-h>", "<cmd>cprev<CR>zz", opts)
keymap("n", "<C-l>", "<cmd>cnext<CR>zz", opts)

-- Move group of lines
keymap("v", "J", "<cmd>move '>+1<CR>gv=gv", opts)
keymap("v", "K", "<cmd>move '<-2<CR>gv=gv", opts)
keymap("i", "<C-j>", "<esc><cmd>m .+1<CR>==i", opts)
keymap("i", "<C-k>", "<esc><cmd>m .-2<CR>==i", opts)

-- Fugitive and merge conflicts
keymap("n", "<leader>gs", "<cmd>G<CR>", opts)
keymap("n", "<leader>gj", "<cmd>diffget //3<CR>", opts)
keymap("n", "<leader>gf", "<cmd>diffget //2<CR>", opts)

-- Keep focus in the center
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

-- Allow for smaller chunks of undos (can add more breakpoints)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", ",", ",<c-g>u", opts)
keymap("i", "!", "!<c-g>u", opts)
keymap("i", "?", "?<c-g>u", opts)

-- Replace multiple occurences of a word. Magic.
keymap("n", "cn", "*``cgn", opts)
keymap("n", "cN", "*``cgN", opts)

-- Don't replace my clipboard when pasting
keymap("v", "p", '"_dP', opts)

-- File explorer
keymap("n", "sf", "<cmd>NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>tp", "<cmd>lua require'md.plugins.telescope'.project_files()<CR>", opts)
keymap("n", "<leader>ttp", "<cmd>lua require'md.plugins.telescope'.work_project_files()<CR>", opts)
keymap("n", "<leader>tg", "<cmd>lua require'md.plugins.telescope'.live_grep()<CR>", opts)
keymap("n", "<leader>ttg", "<cmd>lua require'md.plugins.telescope'.work_live_grep()<CR>", opts)
keymap("n", "<leader>tc", "<cmd>Telescope commands<CR>", opts)
keymap("n", "<leader>tf", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<leader>t.", "<cmd>lua require'md.plugins.telescope'.search_dotfiles()<CR>", opts)
keymap("n", "<leader>tb", "<cmd>lua require'md.plugins.telescope'.search_buffers()<CR>", opts)
keymap("n", "<leader>ww", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", opts) -- worktree: switch and delete (<c-f> ?) worktrees
keymap("n", "<leader>wa", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", opts) -- worktree: create a worktree

-- Harpoon
keymap("n", "<leader>hw", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>hc", "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>ha", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>hs", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>hd", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>hf", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
