if !exists('g:loaded_telescope') | finish | endif

" search a file
nnoremap <leader>tp <cmd>lua require'telescope.builtin'.git_files{}<CR>
" search a buffer
nnoremap <leader>tb <cmd>Telescope buffers<CR>
" grep search
nnoremap <leader>tg <cmd>Telescope live_grep<CR>
" search config files
nnoremap <leader>t. <cmd>lua require'telescope.builtin'.find_files{ cwd = "~/.config/", prompt_title="Search in config files" }<CR>
" experimental… include hidden files
nnoremap <leader>q <cmd>lua require'telescope.builtin'.find_files{ find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" } }<CR>
" experimental… grep all files
nnoremap <leader>ta <cmd>lua require'telescope.builtin'.find_files({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' }, prompt_title = "Find All Files" })<CR>

lua << EOF
  local actions = require('telescope.actions')
  require('telescope').setup {
    defaults = {
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      prompt_prefix = ' > ',
      color_devicons = true,

      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

      mappings = {
        i = {
          ["<C-x>"] = "delete_buffer",
          ["<leader>tq"] = actions.send_to_qflist,
        },
      }
    },
  }

  local M = {}

  M.search_dotfiles = function()
    require("telescope.builtin").find_files({
      prompt_title = "< VimRC >",
      cwd = "$HOME/.config/",
    })
  end

  return M
EOF
