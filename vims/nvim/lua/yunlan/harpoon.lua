require "harpoon".setup {}

vim.cmd [[ nnoremap <leader>ha <cmd>lua require("harpoon.mark").add_file()<cr> ]]
vim.cmd [[ nnoremap <leader>hm <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr> ]]

for i = 1, 5 do
	vim.g.__harpoon_file_idx = i
  vim.cmd [[
		exe "nnoremap" "<leader>" .. g:__harpoon_file_idx "<cmd>lua require('harpoon.ui').nav_file(" .. g:__harpoon_file_idx .. ")<cr>"
	]]
end

vim.g.__harpoon_file_idx = nil
