-- :h options
local options = {
  wildmenu = true,
  wildmode = { 'longest', 'list', 'full' },
  completeopt = {'menuone', 'noselect'}, -- setup for autocompletion...
  mouse = 'a', -- enable mouse in neovim, I shall be punished by death
  number = true,
  relativenumber = true,
  clipboard = 'unnamedplus',
  inccommand = 'split', -- display search results incrementally
  -- syntax = true, -- not sure about it
  background = 'dark',
  encoding = 'utf-8',
  title = true, -- sets the window title to filename [+=-] (path) - NVIM
  backup = false,
  pumheight = 10, -- pop up menu height
  cmdheight = 2, -- more space for the command line bar
  signcolumn = 'yes', -- when and how to draw the signcolumn
  scrolloff = 10, -- minimal number of screen line above/below cursor
  sidescrolloff = 8, -- horizontal scrolloff
  expandtab = true, -- convert tab to spaces
  shell = 'zsh', -- default shell for :! commands
  lazyredraw = true, -- supposed to be good for performance
  regexpengine = 1, -- supposed to be good for performance
  ignorecase = true, -- ignore case in search patters
  -- filetype = {'plugin', 'indent', 'on'} -- I have a feeling this shouldn't be on
  shiftwidth = 2, -- number of space for each indentation
  tabstop = 2, -- number of space that a tab counts for
  numberwidth = 2, -- set number column width to 2 {default 4}
  smartindent = true, -- start a new line with proper indentation
  -- showtabline = 2, -- always show tabs
  wrap = false,
  cursorline = false,
  splitbelow = true, -- force horizontal split to go below active buffer
  splitright = true, -- force vertical split to go to the right of the active buffer
  swapfile = false, -- enable/disable swap files
  timeoutlen = 300, -- time out for mappings to fire
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (default is 4000)
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
}

vim.opt.shortmess:append "c" -- related to removing window messages for searches, completion, etc.

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set path+=**" -- preferences for :find
