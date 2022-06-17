local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.setup = function()
	local icons = require("md.core.icons")
	local signs = {

		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
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
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
end

-- local notify_status_ok, notify = pcall(require, "notify")
-- if not notify_status_ok then
--   return
-- end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = true
	end
	if client.name == "lua" then
		client.server_capabilities.document_formatting = true
	end
	-- vim.notify(client.name .. " starting...")
	-- TODO: refactor this into a method that checks if string in list
	lsp_keymaps(bufnr)
end

function M.enable_format_on_save()
	local group = vim.api.nvim_create_augroup("format_on_save", { clear = false })
	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function()
			vim.lsp.buf.format()
		end,
		group = group,
	})
	require("notify")("Enabled format on save", "info", { title = "LSP", timeout = 2000 })
end

function M.disable_format_on_save()
	vim.api.nvim_del_augroup_by_name("format_on_save")
	require("notify")("Disabled format on save", "info", { title = "LSP", timeout = 2000 })
end

function M.toggle_format_on_save()
	if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
		M.enable_format_on_save()
	else
		M.disable_format_on_save()
	end
end

vim.api.nvim_create_user_command("LspToggleAutoFormat", 'lua require("md.lsp.handlers").toggle_format_on_save()', {})

return M
