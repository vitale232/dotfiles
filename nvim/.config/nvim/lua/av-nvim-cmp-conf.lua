local cmp = require 'cmp'
local lspkind = require 'lspkind'
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}

cmp.setup({
    performance = {
        trigger_debounce_time = 100
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- For `vsnip` users.
            -- vim.fn["vsnip#anonymous"](args.body)

            -- For `luasnip` users.
            require('luasnip').lsp_expand(args.body)

            -- For `snippy` users.
            -- require('snippy').expand_snippet(args.body)

            -- For `ultisnips` users.
            -- vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. " " .. menu
				end
				vim_item.kind = ""
			end
			vim_item.menu = menu
			return vim_item
		end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is
            -- selected, will confirm the last line
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, {"i", "s", "c", }),
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    fallback()
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, {"i", "s", "c", })
    }),
    sources = cmp.config.sources({{
        name = 'cmp_tabnine'
    }, {
        name = 'nvim_lsp'
    },
    {
        name = 'luasnip'
    }
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    }, {{
        name = 'buffer'
    }})
})

cmp.setup.filetype('', {
    sources = cmp.config.sources({{
        name = 'cmp_git'
    } -- You can specify the `cmp_git` source if you were installed it.
    }, {{
        name = 'buffer'
    }})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({{
        name = 'cmp_git'
    } -- You can specify the `cmp_git` source if you were installed it.
    }, {{
        name = 'buffer'
    }})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{
        name = 'buffer'
    }}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{
        name = 'path'
    }}, {{
        name = 'cmdline'
    }})
})

-- Setup lspconfig
local lsp_defaults = {
    flags = {
        debounce_text_changes = 150
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
        vim.api.nvim_exec_autocmds('User', {
            pattern = 'LspAttached'
        })
    end
}

local lspconfig = require('lspconfig')

lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, lsp_defaults)
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['rls'].setup {
    capabilities = capabilities
}
require('lspconfig')['angularls'].setup {
    capabilities = capabilities
}

-- local languageServerPath = vim.fn.stdpath("config").."/languageserver"
-- local cmd = {"ngserver", "--stdio", "--tsProbeLocations", languageServerPath , "--ngProbeLocations", languageServerPath}
--
-- local file = io.open(vim.fn.getcwd()..'/node_modules/@angular/core/package.json', 'r')
-- if file then
--     local file_contents = file:read('*all')
--     if tonumber(file_contents.match(file_contents, [["version": "(%d+).%d+.%d+"]])) < 9 then
--         table.insert(cmd, "--viewEngine")
--     end
-- end

-- require('lspconfig')['angularls'].setup{
--     capabilities = capabilities,
--     cmd = cmd,
--     on_new_config = function(new_config, new_root_dir)
--         new_config.cmd = cmd
--     end,
-- }
local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
