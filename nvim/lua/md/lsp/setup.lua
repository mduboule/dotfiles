-- Setup lsp config
local typescript_ok, typescript = pcall(require, "typescript")

--[[
lsp_installer.setup {
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = { "bashls", "cssls", "eslint", "graphql", "html", "jsonls", "sumneko_lua", "tailwindcss", "tsserver", "vetur", "vuels" },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
  automatic_installation = true,
}
]]
--

local lspconfig = require("lspconfig")
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}
local opts = { noremap = true, silent = true }

local function on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- *
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- * tip: use <C-t> to jump back!
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- *
	buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts) -- *
	buf_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- *
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- *
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- *
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	-- set up buffer keymaps, etc.
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
	capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

-- Order matters

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescript_ok then
	typescript.setup({
		disable_commands = false, -- prevent the plugin from creating Vim commands
		disable_formatting = false, -- disable tsserver's formatting capabilities
		debug = false, -- enable debug logging for commands
		-- LSP Config options
		server = {
			capabilities = require("md.lsp.servers.tsserver").capabilities,
			handlers = handlers,
			on_attach = require("md.lsp.servers.tsserver").on_attach,
		},
	})
end

lspconfig.tailwindcss.setup({
	capabilities = require("md.lsp.servers.tsserver").capabilities,
	filetypes = require("md.lsp.servers.tailwindcss").filetypes,
	handlers = handlers,
	init_options = require("md.lsp.servers.tailwindcss").init_options,
	on_attach = require("md.lsp.servers.tailwindcss").on_attach,
	settings = require("md.lsp.servers.tailwindcss").settings,
})

lspconfig.eslint.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = require("md.lsp.servers.eslint").on_attach,
	settings = require("md.lsp.servers.eslint").settings,
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("md.lsp.servers.jsonls").settings,
})

lspconfig.sumneko_lua.setup({
	handlers = handlers,
	on_attach = on_attach,
	settings = require("md.lsp.servers.sumneko_lua").settings,
})

lspconfig.vuels.setup({
	filetypes = require("md.lsp.servers.vuels").filetypes,
	handlers = handlers,
	init_options = require("md.lsp.servers.vuels").init_options,
	on_attach = on_attach,
})

for _, server in ipairs({ "bashls", "cssls", "graphql", "theme_check", "html", "volar" }) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		handlers = handlers,
	})
end
