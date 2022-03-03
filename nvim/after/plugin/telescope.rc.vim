if !exists('g:loaded_telescope') | finish | endif

" search a file
nnoremap <leader>tp <cmd>Telescope git_files<CR>
" search a buffer
nnoremap <leader>tb <cmd>Telescope buffers<CR>
" grep search
nnoremap <leader>tg <cmd>Telescope live_grep<CR>
" list all commands
nnoremap <leader>tc <cmd>Telescope commands<CR>
" fuzzy find over current buffer
nnoremap <leader>tf <cmd>Telescope current_buffer_fuzzy_find<CR>
" search config files
nnoremap <leader>t. <cmd>lua require'telescope.builtin'.find_files{ cwd = "~/.config/", prompt_title="Search in config files" }<CR>
" experimental… include hidden files
nnoremap <leader>q <cmd>lua require'telescope.builtin'.find_files{ find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" } }<CR>
" experimental… grep all files
nnoremap <leader>ta <cmd>lua require'telescope.builtin'.find_files({ vimgrep_arguments = { 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' }, prompt_title = "Find All Files" })<CR>
" worktree: switch and delete (<c-f> ?) worktrees
nnoremap <leader>ww <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
" worktree: create a worktree
nnoremap <leader>wa <cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>

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

  require("telescope").load_extension("git_worktree")
  require("telescope").load_extension("fzy_native")

  local M = {}

  M.search_dotfiles = function()
    require("telescope.builtin").find_files({
      prompt_title = "< VimRC >",
      cwd = "$HOME/.config/",
    })
  end

  return M
EOF
