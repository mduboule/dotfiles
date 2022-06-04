local status_ok, ls = pcall(require, 'luasnip')
if not status_ok then
  return
end

local types = require "luasnip.util.types"

-- Load lua snippets
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

ls.config.set_config {
  enable_autosnippets = true,
  history = true, -- keep around the last snippet local to jump back
  updateevents = "TextChanged,TextChangedI", -- update changes as you type

  ext_opts = {
    -- some highlights
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
    -- tag a choice node
    [require("luasnip.util.types").choiceNode] = {
      active = {
        virt_text = { { "●", "base00" } },
      }
    }
  },
}

-- create snippet
-- s(context, nodes, condition, ...)
-- local snippet = ls.s
-- local events = require "luasnip.util.events"

require("luasnip.loaders.from_vscode").load({"./snippets"}) -- Load snippets from snippets folder
-- ls.snippets = {

--   all = {
--     ls.parser.parse_snippet("red", "* { color: red !important; }"),
--     ls.parser.parse_snippet("cl", "console.log(\'$TM_FILENAME#$TM_LINE_NUMBER \', $1)"),
--     ls.parser.parse_snippet("ct", "console.table(\'$TM_FILENAME#$TM_LINE_NUMBER \', $1)"),
--   },
--
--   lua = {
--     ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend")
--   },
-- }


-- ls.autosnippets = {
--   all = {
--     ls.parser.parse_snippet("$file$", "$TM_FILENAME"),
--   },
-- }
-- shorcut to source my luasnips file again, which will reload my snippets -- @tjdevries | maybe requires nvim 0.7?

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<leader-y>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<leader-x>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<a-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- @tjdevries: shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/md/luasnip.lua<CR><cmd>echo 'reload snippets'<CR>")
