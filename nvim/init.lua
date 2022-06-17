pcall(require, "impatient")

require("md.core.reload")
require("md.core.worktree")

require("md.user.autocommands")
require("md.user.options")
require("md.user.keymaps")
require("md.user.colors")

require("md.lsp")

require("md.plugins.plugins")
require("md.plugins.comments")
require("md.plugins.nvim-tree")
require("md.plugins.gitsigns")
require("md.plugins.completion")
require("md.plugins.treesitter")
-- require 'md.plugins.lspconfig'
require("md.plugins.luasnip")
require("md.plugins.autopairs")
require("md.plugins.indentation")
require("md.plugins.lualine")
require("md.plugins.winbar")
require("md.plugins.gps")
