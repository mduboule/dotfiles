-- TODO: break this file into submodules like it should be
-- Debut mode
-- vim.lsp.set_log_level("debug")

local status_lsp, nvim_lsp = pcall(require, 'lspconfig')
if not status_lsp then
  return
end

local status_protocol, protocol = pcall(require, 'vim.lsp.protocol')
if not status_protocol then
  return
end

-- Mappings
local opts = { noremap = true, silent = true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- * = most useful ones
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts) -- *
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts) -- * tip: use <C-t> to jump back!
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts) -- *
  buf_set_keymap('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts) -- *
  buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) -- *
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts) -- *
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- *
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- formatting
  if client.name == 'tsserver' then
    client.server_capabilities.document_formatting = false
  end

  if client.server_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    vim.api.nvim_command [[augroup END]]
  end

end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  protocol.make_client_capabilities()
)

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities,
}

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.jsonls.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.theme_check.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      },
      diagnostics = {
        globals = {'vim'}, -- Get the language server to recognize the `vim` global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
      },
      telemetry = {
        enable = false, -- Do not send telemetry data containing a randomized but unique identifier
      },
    },
  },
}

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)

-- more icons
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end


vim.diagnostic.config(
  {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
)

nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'liquid', 'typescript', 'typescriptreact', 'css', 'scss' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
      },
      prettier = {
        command = 'prettier_d_slim',
        rootPatterns = { '.git' },
        -- requiredFiles: { 'prettier.config.js' },
        args = { '--stdin', '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      scss = 'prettier',
      javascript = 'prettier',
      javascriptreact = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'prettier',
      json = 'prettier'
    }
  }
}

