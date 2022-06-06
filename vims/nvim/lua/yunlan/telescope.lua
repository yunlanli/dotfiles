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

local function toggle_hidden_files(prompt_bufnr)
	-- TODO: actually toggle instead of show hidden files every time
	-- b:telescope_show_hidden_files
	--   - not exists -> prev state: hide hidden files
	--   - exists -> prev state: show hidden files
	-- local prev_show_hidden_files = true

	-- set curr buf to prompt_bufnr, access buffer-local telescope_show_hidden_files attr
	-- through vim.b.telescope_show_hidden_files
	--
	-- how to set the buffer-local attr for prompt buffer ???
	--
	-- TODO: after toggle, open the file browser in the correct directory

	actions.close(prompt_bufnr)
	require 'telescope.builtin'.file_browser { hidden = true }
end


-- Wrapper around telescope.actions.smart_send_to_qflist
-- opens quickfix list using trouble.nvim afterwards
local function smart_send_to_qflist(prompt_bufnr)
	require 'telescope.actions'.smart_send_to_qflist(prompt_bufnr)
	vim.cmd [[ Trouble quickfix ]]
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
					["<c-t>"] = set_selected_dir { new_tab = true },
					["<localleader>h"] = toggle_hidden_files,
				},
				n = {
					["o"] = set_selected_dir(),
					["<s-o>"] = set_selected_dir { new_tab = true },
					["h"] = toggle_hidden_files,
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
		},
		live_grep = {
			mappings = {
				n = {
					["q"] = smart_send_to_qflist,
				}
			}
		},
	},
	extensions = {
		fzf = {
			override_generic_sorter = true,
			override_file_sorter = true,
		}
	}
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('project')

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

-- switched to using the telescope-project extension
M.search_projects = function ()
	require("telescope.builtin").file_browser {
		prompt_title = "~ projects ~",
		cwd = "~/Code",
	}
end

M.curbuf = function ()
  local opts = require('telescope.themes').get_dropdown {
		layout_strategy = "center",
		layout_config = {
			width = 0.5
		},
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

return M
