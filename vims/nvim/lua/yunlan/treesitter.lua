require'nvim-treesitter.configs'.setup {
	-- Couldn't get haskell parser installed
	-- skipping it for now
	ensure_installed = "all",
	ignore_install = { "haskell" },
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
