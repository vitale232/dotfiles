local cmp = require("cmp")
local lspkind = require("lspkind")

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}

cmp.setup({
	completion = { autocomplete = false }, -- for debounce
	flags = {},
	performance = {},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			vim_item.menu = menu
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		["<C-Space>"] = cmp.mapping.complete({}),
		-- People change.
		-- https://www.youtube.com/watch?v=_DnmphIwnjo
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	-- This little snippet will confirm with tab, and if no entry is
		-- 	-- selected, will confirm the last line
		-- 	if cmp.visible() then
		-- 		local entry = cmp.get_selected_entry()
		-- 		if not entry then
		-- 			cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
		-- 		else
		-- 			cmp.confirm()
		-- 		end
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s", "c" }),
		-- ["<CR>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		local entry = cmp.get_selected_entry()
		-- 		if not entry then
		-- 			fallback()
		-- 		else
		-- 			cmp.confirm()
		-- 		end
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s", "c" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 4 },
		{ name = "spell" },
	},
	experimental = {
		ghost_text = true,
	},
})

cmp.setup.filetype("", {
	sources = cmp.config.sources({
		{
			name = "cmp_git",
		}, -- You can specify the `cmp_git` source if you were installed it.
	}, { {
		name = "buffer",
		keyword_length = 5,
	} }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" },
		{ name = "buffer", keyword_length = 4 },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { {
		name = "buffer",
	} },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ {
		name = "path",
	} }, { {
		name = "cmdline",
	} }),
})

-- debounce cmp
vim.cmd([[
  augroup CmpDebounceAuGroup
    au!
    au TextChangedI * lua require("debounce").debounce()
  augroup end
]])
