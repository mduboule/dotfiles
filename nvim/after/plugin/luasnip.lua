if vim.g.snippets ~= "luasnip" then
  return
end

local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
  },
}

-- Insert Node
--  Creates a location for the cursor to jump to.
--      Possible options to jump to are 1 - N
--      If you use 0, that's the final place to jump to.
--
--  To create placeholder text, pass it as the second argument
--      i(2, "this is placeholder text")
local i = ls.insert_node

ls.filetype_extend("liquid", { "liquid" })

ls.snippets = {
  all = {
    ls.parser.parse_snippet("red", "* { color: red !important; }"),
    ls.parser.parse_snippet("cl", "console.log(\'$TM_FILENAME#$TM_LINE_NUMBER \', $1)"),
    ls.parser.parse_snippet("ct", "console.table(\'$TM_FILENAME#$TM_LINE_NUMBER \', $1)"),
  },

  lua = {
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend")
  },
}

require("luasnip.loaders.from_vscode").load({ include = { "liquid" } }) -- Load only liquid snippets
require("luasnip.loaders.from_vscode").load({ include = { "javascript" } }) -- Load only liquid snippets
-- require("luasnip.loaders.from_vscode").load({ paths = { "./snippets" } }) -- Load snippets from snippets folder
--
-- -- require("luasnip.loaders.from_vscode").load()

-- require'luasnip'.filetype_extend("liquid", {"liquid"})
-- require'luasnip'.filetype_extend("javascript", {"javascript"})

-- shorcut to source my luasnips file again, which will reload my snippets -- @tjdevries | maybe requires nvim 0.7?
-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

vim.keymap.set({ "i", "s" }, "<leader>y", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-B>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- @tjdevries: shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR><cmd>echo 'reload snippets'<CR>")
