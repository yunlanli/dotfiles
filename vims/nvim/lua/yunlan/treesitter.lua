require'nvim-treesitter.configs'.setup {
	-- Couldn't get haskell parser installed
	-- skipping it for now
	ensure_installed = "all",
	ignore_install = { "haskell" },
	sync_install = false,

	highlight = {
		enable = true,
		-- vimtex relies on the syntax file to determine syntax zones
		disable = { 'latex', 'bibtex' },
		additional_vim_regex_highlighting = false,
	},

	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	}
}
