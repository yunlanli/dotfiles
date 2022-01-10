set inccommand=split

nmap <leader>vl :lua R('yunlan')<cr>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank { on_visual = false, timeout = 150}
augroup END
