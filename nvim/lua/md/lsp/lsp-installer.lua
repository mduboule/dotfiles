local servers = {
  "bashls",
  "cssls",
  -- "cssmodules_ls", this lsp needs to be installed properly or something
  -- "emmet_ls",
  "html",
  "jsonls",
  "tailwindcss",
  "sumneko_lua",
  "tsserver",
  "theme_check",
  "yamlls",
  "clangd",
  "vuels"
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("md.lsp.handlers").on_attach,
    capabilities = require("md.lsp.handlers").capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require "md.lsp.servers.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "tailwindcss" then
    local tailwind_opts = require "md.lsp.servers.tailwindcss"
    opts = vim.tbl_deep_extend("force", tailwind_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require "md.lsp.servers.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "md.lsp.servers.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  lspconfig[server].setup(opts)
end
