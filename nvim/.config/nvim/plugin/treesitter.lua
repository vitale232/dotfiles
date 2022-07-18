require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"angular",
		"css",
		"html",
		"lua",
		"python",
		"rust",
		"typescript",
	},
	sync_install = false,
	highlight = {
		enable = true,
	},
})
