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
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

return packer.startup(function(use)
  -- Plugin manager
  use { "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" }

  -- Libraries
  use { "nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" }
  use { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }
  use { "kyazdani42/nvim-web-devicons", commit = "a8cf88cbdb5c58e2b658e179c4b2aa997479b3da" }

  -- T Pope 4ever
  use { "tpope/vim-fugitive", commit = "dd8107cabf5fe85df94d5eedcae52415e543f208" }
  use { "tpope/vim-surround", commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea", event = 'BufRead' }
  use { "tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" }

  -- Editing
  use { "nvim-lualine/lualine.nvim", commit = "edca2b03c724f22bdc310eee1587b1523f31ec7c" }
  use "karb94/neoscroll.nvim"
  -- use "psliwka/vim-smoothie" -- smooth scrolling
  use { "numToStr/Comment.nvim", commit = "250bbc5a04b6e80ff1c212e89a80e976cda9e433" }
  use { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347", event = 'BufRead' }
  use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" } -- add indentation marks
  use { "ThePrimeagen/harpoon", commit = "4dfe94e633945c14ad0f03044f601b8e6a99c708" }
  -- use { "aca/emmet-ls", event = 'BufRead' }
  use { "SmiteshP/nvim-navic", commit = "132b273773768b36e9ecab2138b82234a9faf5ed" }

  -- Lsp / treesitter
  use { "neovim/nvim-lspconfig", commit = "28ec7c4f4ad4701a88024fb8105ac7baff7d4f2a" }
  use { "jose-elias-alvarez/null-ls.nvim", commit = "3d9e5f6bf029fcda0eed08915bed3d5052c6d804" } -- for formatters and linters
  -- use { 'jose-elias-alvarez/typescript.nvim' }
  use { "nvim-treesitter/nvim-treesitter", commit = "82767f3f33c903e92f059dc9a2b27ec38dcc28d7", run = ':TSUpdate' }
  use { "ray-x/lsp_signature.nvim", commit = "e65a63858771db3f086c8d904ff5f80705fd962b" }
  use { "rcarriga/nvim-notify", commit = "56f65a9474e9ce294a89eb325fccf4391646bfd4" }
  use { "b0o/SchemaStore.nvim", commit = "f19237d0d257bc758b7ca7773b13cac80e33cbdd" }
  use { "RRethy/vim-illuminate", commit = "0603e75fc4ecde1ee5a1b2fc8106ed6704f34d14" }

  -- Git
  use { "ThePrimeagen/git-worktree.nvim", commit = "d7f4e2584e81670154f07ca9fa5dd791d9c1b458" }
  use { "f-person/git-blame.nvim", commit = "08e75b7061f4a654ef62b0cac43a9015c87744a2" }
  use { "lewis6991/gitsigns.nvim", commit = "9d18976c10413e52d76d41a771f042704786ce2e", event = 'BufRead' }

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "f174a0367b4fc7cb17710d867e25ea792311c418" }
  use { "nvim-telescope/telescope-fzy-native.nvim", commit = "282f069504515eec762ab6d6c89903377252bf5b" }

  -- Autocompletion
  use { "hrsh7th/nvim-cmp", commit = "714ccb7483d0ab90de1b93914f3afad1de8da24a" }
  use { "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" }
  use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }

  -- Snippets
  use { "L3MON4D3/LuaSnip", commit = "80df2824d89f3c9c45d3b06494c7e89ca4e0c70e" }
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }
  use { "rafamadriz/friendly-snippets", commit = "fd16b4d9dc58119eeee57e9915864c4480d591fd" }

  -- Filer
  use { "kyazdani42/nvim-tree.lua", commit = "b01e7beaa6f0dbbf5df775cf4ecc829a23f0be54" }

  -- Colors
  use { "lunarvim/darkplus.nvim", commit = "f20cba5d690bc34398a3a8372ee7bbbc7b6609fa" }
  use { "nvim-colortils/colortils.nvim", commit = "49bbc9c849fa279378d451765f4a978878691c42" }

  -- Performance
  use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
  use { "dstein64/vim-startuptime", commit = "1a5fe7b6275d8f62647969012dcd5bcceb2cebc6" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
