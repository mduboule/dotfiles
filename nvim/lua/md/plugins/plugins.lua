local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  -- Plugin manager
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Libraries
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used in lots of plugins
  use { "kyazdani42/nvim-web-devicons", event = 'BufRead' }

  -- T Pope 4ever
  use "tpope/vim-fugitive"
  use { "tpope/vim-surround", event = 'BufRead' }
  use "tpope/vim-repeat"

  -- Editing
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use "psliwka/vim-smoothie" -- smooth scrolling
  use "numToStr/Comment.nvim"
  use { "windwp/nvim-autopairs", event = 'BufRead' }
  use "lukas-reineke/indent-blankline.nvim" -- add indentation marks
  use "ThePrimeagen/harpoon"
  -- use { "aca/emmet-ls", event = 'BufRead' }
  use "fgheng/winbar.nvim"
  use { "christianchiarulli/nvim-gps", branch = "text_hl" }

  -- Lsp / treesitter
  use 'neovim/nvim-lspconfig'
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- use { 'jose-elias-alvarez/typescript.nvim' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', }
  use { 'NvChad/nvim-colorizer.lua', config = "require('md.plugins.colorizer')" }
  use { 'rcarriga/nvim-notify' }
  use "b0o/SchemaStore.nvim"

  -- Git
  use 'ThePrimeagen/git-worktree.nvim'
  -- use 'f-person/git-blame.nvim'
  use { 'lewis6991/gitsigns.nvim', event = 'BufRead' }

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"

  -- Autocompletion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-nvim-lsp"

  -- Snippets
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

  -- Filer
  use "kyazdani42/nvim-tree.lua"

  -- Colors
  use "lunarvim/darkplus.nvim"

  -- Performance
  use 'lewis6991/impatient.nvim'
  use 'dstein64/vim-startuptime'

  -- Do I need any of those?
  --  use "akinsho/bufferline.nvim"
  --  use "moll/vim-bbye"
  --  use "akinsho/toggleterm.nvim"
  --  use "ahmedkhalf/project.nvim"
  --  use "lewis6991/impatient.nvim"
  --  use "goolord/alpha-nvim"
  --  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  --  use "folke/which-key.nvim"

  -- LSP
  -- use "neovim/nvim-lspconfig" -- enable LSP
  -- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  --  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
