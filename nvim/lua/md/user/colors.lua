vim.cmd [[
try
  " colorscheme NeoSolarized
  colorscheme darkplus
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
