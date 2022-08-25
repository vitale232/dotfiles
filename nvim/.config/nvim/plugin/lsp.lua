local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local eslint = require("eslint")

-- Setup lspconfig
lspconfig.ccls.setup({})

local lsp_defaults = {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds("User", {
			pattern = "LspAttached",
		})
	end,
}

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
local opts = {
	tools = { -- rust-tools options
		autoSetHints = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
		-- on_attach = on_attach,
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}
require("lspconfig")["rust_analyzer"].setup({})
require("rust-tools").setup(opts)
require("lspconfig")["angularls"].setup({
	capabilities = capabilities,
})
null_ls.setup({
	sources = {
		-- disable eslint (next 2 lines) for pa-share
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	},
})

lspconfig.pyright.setup({})

lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

local on_attach = function(client, bufnr)
	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
end

lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)

		buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
		buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
		buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

		on_attach(client, bufnr)
	end,
})

eslint.setup({
	-- bin = 'eslint', -- or `eslint_d`
	bin = "eslint_d",
	code_actions = {
		enable = true,
		apply_on_save = {
			enable = true,
			types = { "problem" }, -- "directive", "problem", "suggestion", "layout"
		},
		disable_rule_comment = {
			enable = true,
			location = "separate_line", -- or `same_line`
		},
	},
	diagnostics = {
		enable = true,
		report_unused_disable_directives = false,
		run_on = "type", -- or `save`
	},
})

-- local snippets_paths = function()
-- 	local plugins = { "friendly-snippets" }
-- 	local paths = {}
-- 	local path
-- 	local root_path = vim.env.HOME .. "/.vim/plugged/"
-- 	for _, plug in ipairs(plugins) do
-- 		path = root_path .. plug
-- 		if vim.fn.isdirectory(path) ~= 0 then
-- 			table.insert(paths, path)
-- 		end
-- 	end
-- 	return paths
-- end

-- require("luasnip.loaders.from_vscode").lazy_load({
-- 	paths = snippets_paths(),
-- 	include = nil, -- Load all languages
-- 	exclude = {},
-- })
--
-- require("luasnip.loaders.from_vscode").lazy_load({
-- 	paths = snippets_paths(),
-- 	include = nil, -- Load all languages
-- 	exclude = {},
-- })
