vim.opt.list = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#3E4452 gui=nocombine]]

require("indent_blankline").setup {
  -- can be slow according to doc
  show_current_context = true,
  show_current_context_start = true,
  char_highlight_list = {
    "IndentBlanklineIndent1"
  },
  -- TESTS
  use_treesitter = true,
  -- pace_char_highlight_list = 'a',
  -- space_char_blankline_highlight_list = 'b',
  -- indent_level = 6,
  -- show_first_indent_level = true,
  -- max_indent_increase = 1,
  -- char_list = ' ',
  -- show_foldtext = false,
  space_char_blankline = ' '
}
