require'nvim-treesitter.configs'.setup {
	ensure_installed = {"typescript", "angular", "html", "css", "rust"},
	sync_install = false,
	highlight = {
		enable = true,
	}
}
