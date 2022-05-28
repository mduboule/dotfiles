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
