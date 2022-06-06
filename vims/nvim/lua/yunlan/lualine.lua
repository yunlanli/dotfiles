local lualine = require 'lualine'
local devicons = require 'nvim-web-devicons'

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

local function get_file_suffix()
	local path_comps = vim.fn.split(vim.fn.expand("%"), "/")
	local filename = path_comps[#path_comps]
	local fn_comps = vim.fn.split(filename, "\\.")
	local fn_suffix = fn_comps[#fn_comps]

	return fn_suffix
end

-- TODO: change icon color after switching buffer
local function get_ftp_color()
	local _, ftp_color = devicons.get_icon_color("", get_file_suffix())

	return ftp_color
end

local function get_ftp_icon()
	return devicons.get_icon("", get_file_suffix(), { default = true })
end

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
				get_ftp_icon,
				color = { fg = get_ftp_color() },
				padding = { right = -1 }
			},
			{
				'filename',
				file_status = true,
				path = 1,
				shorting_target = 40,
				symbols = {
					modified = ' [+]',
					readonly = ' [-]',
					unnamed = '[No Name]'
				},
			}
		},
		lualine_x = {},
		lualine_y = {
			{
				'filetype',
				icons_enabled = false,
			},
			'encoding'
		},
		lualine_z = { 'progress', 'location' },
	},

	inactive_sections = {
		lualine_a = {
			{
				'mode',
				color = { fg = '#ffffff', bg = '#333a48' }
			}
		},
		lualine_b = {
			{
				'branch',
				color = { fg = '#ffffff', bg = '#333a48' }
			},
			{
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = { error = ' ', warn = ' ', info = ' ' },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
				color = { fg = '#ffffff', bg = '#333a48' }
			},
		},
		lualine_c = {
			'%=',
			{
				get_ftp_icon,
				color = { fg = colors.ftp },
				padding = { right = -1 }
			},
			{
				'filename',
				file_status = true,
				path = 1,
				shorting_target = 40,
				symbols = {
					modified = ' [+]',
					readonly = ' [-]',
					unnamed = '[No Name]'
				},
			}
		},
		lualine_x = { },
		lualine_y = {
			{
				'filetype',
				icons_enabled = false,
			},
			'encoding'
		},
		lualine_z = {
			{
				'progress',
				color = { fg = '#ffffff', bg = '#333a48' }
			},
			{
				'location',
				color = { fg = '#ffffff', bg = '#333a48' }
			}
		},
	},
}
