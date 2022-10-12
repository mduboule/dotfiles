local M = {}

-- `:echo &ft` to print filetype
M.winbar_filetype_exclude = {
  "harpoon",
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
}

local functions = require('md.core.functions')
local icons = require('md.core.icons')

M.get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local full_path = vim.fn.expand "%:p"

  if not functions.isempty(filename) then
    local file_icon, file_icon_color = require("nvim-web-devicons").get_icon_color(
      filename,
      extension,
      { default = true }
    )

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if functions.isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end

    if extension == 'liquid' then
      file_icon = ""
      vim.api.nvim_set_hl(0, "Liquid", { default = true, fg = "#95BF47"})
      hl_group = "Liquid"
    end

    local framework_marker = ""
    if string.find(full_path, "framework") then
      framework_marker = "FW "
    end

    local navic_text = vim.api.nvim_get_hl_by_name("NavicText", true)
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.fg })

    return " " .. framework_marker .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-navic")
  if not status_gps_ok then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not require("md.core.functions").isempty(gps_location) then
    return icons.ui.ChevronRight .. " " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local value = M.get_filename()

  local gps_added = false
  if not functions.isempty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value
    if not functions.isempty(gps_value) then
      gps_added = true
    end
  end

  if not functions.isempty(value) and functions.get_buf_option "mod" then
    local mod = "%#LineNr#" .. require('md.core.icons').ui.Circle .. "%*"
    if gps_added then
      value = value .. " " .. mod
    else
      value = value .. mod
    end
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  if vim.fn.has "nvim-0.8" == 1 then
    vim.api.nvim_create_autocmd(
      { "CursorMoved", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
      {
        group = "_winbar",
        callback = function()
          local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
          if not status_ok then
            require("md.plugins.winbar").get_winbar()
          end
        end,
      }
    )
  end
end

M.create_winbar()

return M
