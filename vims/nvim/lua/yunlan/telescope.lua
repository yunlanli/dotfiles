local Path = require "plenary.path"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function set_selected_dir(opt)
	opt = opt or {}

	return function (prompt_bufnr)
		local selected_entry = action_state.get_selected_entry()
		local selected_dir = selected_entry.cwd .. '/' .. selected_entry.ordinal

		actions.close(prompt_bufnr)

		if opt.new_tab then
			vim.cmd [[ tabnew ]]
		end

		vim.t.cwd = selected_dir
		vim.cmd [[ exe "lcd" t:cwd ]]
		require('telescope.builtin').find_files()
	end
end

local function delete_selected_bufs(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)

	local buf_entries = {}
	for _, entry in ipairs(picker:get_multi_selection()) do
		table.insert(buf_entries, entry)
	end

	for _, entry in ipairs(buf_entries) do
		vim.api.nvim_buf_delete(entry.bufnr, { force = true })
	end

	actions.close(prompt_bufnr)
end

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
	pickers = {
		file_browser = {
			layout_strategy = "bottom_pane",
			layout_config = {
				height = 0.25,
			},
			mappings = {
				i = {
					["<c-o>"] = set_selected_dir(),
					["<c-t>"] = set_selected_dir { new_tab = true }
				},
				n = {
					["o"] = set_selected_dir(),
					["<s-o>"] = set_selected_dir { new_tab = true }
				}
			}
		},
		buffers = {
			mappings = {
				i = {
					-- forcefully wipeout selected buffers
					["<c-d>"] = delete_selected_bufs,
				},
				n = {
					["d"] = delete_selected_bufs,
				}
			}
		}
	},
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

M.search_nvim_plugins = function ()
	require("telescope.builtin").file_browser {
		prompt_title = "~ nvim plugin source code ~",
		cwd = "~/.vim/bundle",
	}
end

M.search_projects = function ()
	require("telescope.builtin").file_browser {
		prompt_title = "~ projects ~",
		cwd = "~/Code",
	}
end

return M
