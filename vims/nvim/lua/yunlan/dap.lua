require 'dapui'.setup {}
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

--[[ table.insert(require('dap').configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'My custom launch configuration',
  program = '${file}',
  -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
}) ]]

-- vim.cmd [[ vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR> ]]
-- vim.cmd [[ nnoremap <leader>db <cmd>lua require'dap'.toggle_breakpoint()<cr> ]]
