require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"angular",
		"c",
		"css",
		"dockerfile",
		"go",
		"html",
		"javascript",
		"json",
		"lua",
		"make",
		"markdown",
		"python",
		"rust",
		"toml",
		"typescript",
	},
	sync_install = false,
	highlight = {
		enable = true,
	},
})
