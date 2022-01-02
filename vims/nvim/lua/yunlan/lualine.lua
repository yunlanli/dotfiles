--[[
-- TODO:
--   - filetype ICONS before filename would be nice!
--]]
local lualine = require 'lualine'

-- Color table for highlights
-- stylua: ignore
local colors = {
	bg       = '#202328',
	fg       = '#bbc2cf',
	yellow   = '#ECBE7B',
	cyan     = '#008080',
	darkblue = '#081633',
	green    = '#98be65',
	orange   = '#FF8800',
	violet   = '#a9a1e1',
	magenta  = '#c678dd',
	blue     = '#51afef',
	red      = '#ec5f67',
}

lualine.setup {
	options = {
		theme = 'nord',
		always_divide_middle = false,
		section_separators = '',
		component_separators = '',
		icons_enabled = true,
	},

	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			'branch',
			{
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = { error = ' ', warn = ' ', info = ' ' },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			},
		},
		lualine_c = {
			'%=',
			{
				'filename',
				file_status = true,
				path = 1,
				shorting_target = 40,
				symbols = {
					modified = ' [+]',
					readonly = ' [-]',
					unnamed = '[No Name]'
				}
			}
		},
		lualine_x = {},
		lualine_y = {
			'filetype',
			'encoding'
		},
		lualine_z = { 'progress', 'location' },
	},

	inactive_sections = {
		lualine_a = {},
		lualine_b = { 'branch' },
		lualine_c = {
			'%=',
			{
				'filename',
				file_status = true,
				path = 1,
				shorting_target = 40,
				symbols = {
					modified = ' [+]',
					readonly = ' [-]',
					unnamed = '[No Name]'
				}
			}
		},
		lualine_x = {'%='},
		lualine_y = {},
		lualine_z = {},
	}
}
