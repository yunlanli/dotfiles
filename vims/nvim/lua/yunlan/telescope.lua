local Path = require "plenary.path"

require('telescope').setup {
	defaults = {
		prompt_prefix = "❯ ",
		selection_caret = "❯ ",
		layout_strategy = "horizontal",
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
			height = 0.8,
		},
	},
	pickers = { },
	extensions = {
		fzf = {
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	}
}

require('telescope').load_extension('fzf')

local M = {}

M.search_dotfiles = function ()
	require("telescope.builtin").find_files({
		prompt_title = "~ dotfiles ~",
		cwd = "~/.dotfiles",
		follow = true,
		hidden = true,
		path_display = function(_, path)
			local shorten = { len = 1, exclude = { 1, 2, -2, -1 } }
			local transformed_path = path.gsub(path, "^./", "")

			return Path:new(transformed_path):shorten(shorten.len, shorten.exclude)
		end,
	})
end

return M
