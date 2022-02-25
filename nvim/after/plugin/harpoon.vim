" hw for Harpoon Write, add file to haroon.
nnoremap <silent><leader>hw :lua require("harpoon.mark").add_file()<CR>
" toggle quick menu.
nnoremap <silent><leader>hh :lua require("harpoon.ui").toggle_quick_menu()<CR>
" i don't know what this is for, looks fancy.
nnoremap <silent><leader>hc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

" navigate through files
nnoremap <silent><leader>ha :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><leader>hs :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><leader>hd :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><leader>hf :lua require("harpoon.ui").nav_file(4)<CR>

" More unknown
" nnoremap <silent><leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
" nnoremap <silent><leader>te :lua require("harpoon.term").gotoTerminal(2)<CR>
" nnoremap <silent><leader>cu :lua require("harpoon.term").sendCommand(1, 1)<CR>
" nnoremap <silent><leader>ce :lua require("harpoon.term").sendCommand(1, 2)<CR>
