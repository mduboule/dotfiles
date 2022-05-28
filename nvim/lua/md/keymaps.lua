local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Source entire config
keymap("n", "<leader><CR>", ":so $MYVIMRC<CR>", opts)

-- Use Command + S (<D-s>) to save. Requires <D-s> to
-- fire <C-z> inside the terminal as an intermediate command.
-- https://stackoverflow.com/a/63458243
keymap("n", "<C-z>", ":w<CR>", opts)
keymap("i", "<C-z>", "<ESC>:w<CR>a", opts)

-- Scroll motions
keymap("n", "<leader>f", "<PageDown>", opts)
keymap("n", "<leader>b", "<PageUp>", opts)
keymap("n", "<leader>d", "<C-d>", opts)
keymap("n", "<leader>u", "<C-u>", opts)

-- Select all
keymap("n", "<leader>b", "gg<S-v>G", opts)

-- Escape
keymap("i", "jk", "<Esc>", opts)

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
keymap("n", "ss", ":split<CR>", opts)
keymap("n", "vs", ":vsplit<CR>", opts)

-- Navigate between windows
keymap("n", "sh", "<C-w>h", opts)
keymap("n", "sj", "<C-w>j", opts)
keymap("n", "sk", "<C-w>k", opts)
keymap("n", "sl", "<C-w>l", opts)

-- Resize windows
keymap("n", "<leader><Up>", ":resize +4<CR>", opts)
keymap("n", "<leader><Down>", ":resize -2<CR>", opts)
keymap("n", "<leader><Left>", ":vertical resize -4<CR>", opts)
keymap("n", "<leader><Right>", ":vertical resize +4<CR>", opts)

-- Who needs H, M and L
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- Open new tab
keymap("n", "te", ":tabedit<CR>", opts)

-- since <Tab> === <C-i> we need to find a new solution
-- for the jump list. And also, put them in the right order
-- while we're at it.
keymap("n", "<leader>o", "<C-i>", opts)
keymap("n", "<leader>i", "<C-o>", opts)

-- Navigate in quickfix lists
keymap("n", "<C-h>", ":cprev<CR>zz", opts)
keymap("n", "<C-l>", ":cnext<CR>zz", opts)

-- Move group of lines
keymap("v", "J", ":move '>+1<CR>gv=gv", opts)
keymap("v", "K", ":move '<-2<CR>gv=gv", opts)
keymap("i", "<C-j>", "<esc>:m .+1<CR>==i", opts)
keymap("i", "<C-k>", "<esc>:m .-2<CR>==i", opts)

-- Fugitive and merge conflicts
keymap("n", "<leader>gs", ":G<CR>", opts)
keymap("n", "<leader>gj", ":diffget //3<CR>", opts)
keymap("n", "<leader>gf", ":diffget //2<CR>", opts)

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
