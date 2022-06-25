local M = {}

M.settings = {
  Lua = {
    diagnostics = {
      globals = { 'vim', 'bit', 'packer_plugins' }
    },
    telemetry = {
      enable = false,
    },
  }
}

return M
