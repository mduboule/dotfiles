local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

local actions = require"telescope.actions"
local sorters = require "telescope.sorters"
local previewers = require "telescope.previewers"
local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

telescope.setup {
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    prompt_prefix = ' > ',
    color_devicons = true,

    file_previewer   = previewers.vim_buffer_cat.new,
    grep_previewer   = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-x>"] = "delete_buffer",
        ["<leader>tq"] = actions.send_to_qflist,
      },
    }
  },
}

telescope.load_extension("git_worktree")
telescope.load_extension("fzy_native")

local M = {}

M.project_files = function()
  local opts = {}
  local ok = pcall(builtin.git_files, opts)
  if not ok then builtin.find_files(opts) end
end

M.search_dotfiles = function()
  builtin.find_files({
    prompt_title = "Search in config files",
    cwd = "$HOME/.config/",
    hidden = true,
  })
end

M.search_buffers = function ()
  local opts = themes.get_dropdown {
    previewer = false,
  }
 builtin.buffers(opts)
end

M.search_SL_framework = function()
	builtin.find_files({
		prompt_title = "Search Framework 2",
		cwd = vim.env.DOTFILES,
		hidden = false,
	})
end

return M
